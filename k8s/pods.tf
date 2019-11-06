resource "kubernetes_pod" "backend" {
  metadata {
    name = "dito-chat-backend"
    labels = {
      App = "dito-chat-backend"
    }
  }

  spec {
    container {
      image = "gcr.io/${var.project}/dito-chat-backend:latest"
      name  = "backend"

      port {
        container_port = 8080
      }

      env {
        name = "ALLOWED_ORIGIN"
        value = "*:3000"
      }
      env {
        name = "REDIS_ADDR"
        value = "127.0.0.1:6379"
      }
    }
    container {
      image = "redis"
      name = "redis"

      port {
        container_port = 6379
      }
    }
  }
}

resource "kubernetes_pod" "frontend" {
  metadata {
    name = "dito-chat-frontend"
    labels = {
      App = "dito-chat-frontend"
    }
  }

  spec {
    container {
      image = "gcr.io/${var.project}/dito-chat-frontend:latest"
      name = "frontend"

      port {
        container_port = 80
      }
    }
  }
}
