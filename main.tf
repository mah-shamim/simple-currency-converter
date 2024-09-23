provider "docker" {}

resource "docker_image" "currency_converter" {
  name         = "currency_converter"
  build {
    context = "."
  }
}

resource "docker_container" "app_container" {
  image = docker_image.simple_calculator.name
  name  = "currency_converter_container"
  ports {
    internal = 80
    external = 9090
  }
}