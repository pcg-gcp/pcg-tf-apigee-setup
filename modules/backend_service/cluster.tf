resource "google_container_cluster" "backend_cluster" {
  name                = "backend-service-cluster"
  location            = var.backend_gke_zone //zonal
  initial_node_count  = 3
  deletion_protection = false
  /*
  private_cluster_config {
    enable_private_nodes = true
    master_ipv4_cidr_block = "172.16.0.32/28"
  }
  */
  network    = google_compute_network.backend_vpc.name
  subnetwork = google_compute_subnetwork.gke_subnetwork.name
  #project = var.backend_gcp_project_id
  depends_on = [google_compute_subnetwork.gke_subnetwork, google_project_service.gcp_apis]
}

resource "kubernetes_deployment" "hostname" {
  depends_on = [google_container_cluster.backend_cluster]
  metadata {
    name = "hostname-server"
    labels = {
      app = "hostname"

    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "hostname"
      }
    }
    template {
      metadata {
        labels = {
          app = "hostname"
        }
      }
      spec {
        container {
          image = "registry.k8s.io/serve_hostname:v1.4"
          name  = "hostname-server"
          port {
            container_port = 9376
            protocol       = "TCP"
          }
        }
        termination_grace_period_seconds = 90
      }
    }
  }
}

resource "kubernetes_service" "hostname-svc" {
  depends_on = [kubernetes_deployment.hostname]
  metadata {
    name      = "hostname"
    namespace = "default"

    annotations = {
      "cloud.google.com/neg" : local.annotation.pattern // Required because of Terraform issue with https://github.com/hashicorp/terraform-provider-helm/issues/1292
    }


  }
  spec {
    port {
      name        = "host1"
      port        = 80
      protocol    = "TCP"
      target_port = 9376
    }
    selector = {
      app = "hostname"
    }
    type = "ClusterIP"

  }

}

resource "kubernetes_deployment" "hello-deploy" {
  depends_on = [google_container_cluster.backend_cluster]
  metadata {
    name = "hello-deploy"
    labels = {
      app = "hello"

    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "hello"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello"
        }
      }
      spec {
        container {
          image = "us-docker.pkg.dev/google-samples/containers/gke/hello-app:2.0"

          name = "hello"
          port {
            container_port = 8080
            protocol       = "TCP"
          }
        }
        termination_grace_period_seconds = 90
      }
    }
  }
}

resource "kubernetes_service" "hello-svc" {
  depends_on = [kubernetes_deployment.hello-deploy]
  metadata {
    name      = "hello-service"
    namespace = "default"
    annotations = {
      "cloud.google.com/neg" : local.annotation.pattern

    }

  }
  spec {
    port {
      name        = "hello1"
      port        = 80
      protocol    = "TCP"
      target_port = 8080
    }
    selector = {
      app = "hello"
    }
    type = "ClusterIP"

  }

}

resource "kubernetes_ingress_v1" "ilb-demo-ingress" {
  metadata {
    name      = "ilb-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class" : "gce-internal"
    }

  }

  spec {
    default_backend {
      service {
        name = "hello-service"
        port {
          number = 80
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = "hostname"
              port {
                number = 80
              }
            }

          }
          path      = "/hostname"
          path_type = "Prefix"
        }

      }


    }

  }


}
locals {
  annotation = yamldecode(file("${path.module}/annotations.yml"))
}
