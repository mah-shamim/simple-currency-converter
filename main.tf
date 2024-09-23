provider "docker" {}

resource "docker_image" "simple_calculator" {
  name         = "simple_calculator"
  build {
    context = "."
  }
}

resource "docker_container" "app_container" {
  image = docker_image.simple_calculator.name
  name  = "simple_calculator_container"
  ports {
    internal = 80
    external = 9090
  }
}