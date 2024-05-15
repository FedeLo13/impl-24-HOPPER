terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "formula1_app" {
  name = "formula1_app"
  keep_locally = true
}

resource "docker_container" "formula1_app" {
  name  = "formula1_app_container"
  image = "formula1_app"
  ports {
    internal = 3333
    external = 3333
  }
}