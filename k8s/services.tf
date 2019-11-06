resource "kubernetes_service" "backend" {
  metadata {
    name = "backend-service"
  }
  spec {
    selector = {
      App = kubernetes_pod.backend.metadata[0].labels.App
    }
    port {
      name = "backend"
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend-service"
  }
  spec {
    selector = {
      App = kubernetes_pod.frontend.metadata[0].labels.App
    }
    port {
      name = "frontend"
      port        = 3000
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
