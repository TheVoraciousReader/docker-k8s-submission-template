resource "kubernetes_deployment" "converter" {
  metadata {
    name = "converter-latest"
    labels = {
      test = "converter"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "converter"
      }
    }

    template {
      metadata {
        labels = {
          test = "converter"
        }
      }

      spec {
        container {
          image = "ghcr.io/adyanth/docker-k8s-final-assessment:converter-latest"
          name  = "service-converter"

          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "counter" {
  metadata {
    name = "counter-latest"
    labels = {
      test = "counter"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "counter"
      }
    }

    template {
      metadata {
        labels = {
          test = "counter"
        }
      }

      spec {
        container {
          image = "ghcr.io/adyanth/docker-k8s-final-assessment:counter-latest"
          name  = "service-counter"

          resources {
            requests = {
              cpu    = "250m"
              memory = "1Gi"
            }
          }

          liveness_probe {
            http_get {
              path = "/data"
              port = 8080
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
