terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "anotaciones_java" {
  name         = "anotaciones-java:latest"
  build {
    context    = path.module
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "anotaciones_java_container" {
  image = docker_image.anotaciones_java.name
  name  = "anotaciones_java_container"
  ports {
    internal = 3200
    external = 3200
  }
}
