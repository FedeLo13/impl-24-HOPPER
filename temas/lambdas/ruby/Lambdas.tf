terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

resource "docker_image" "app_image" {
  name = "my-sinatra-app:latest"
  build {
    context = path.module
    dockerfile = "Dockerfile"
  }
  
}

resource "docker_container" "app_container" {
  image = docker_image.app_image.name
  name = "mi-app-container-lambdas"
  ports {
    internal = 4568
    external = 4568
  }
}