
provider "null" {}

resource "null_resource" "install_ruby" {
  provisioner "local-exec" {
    command = "choco install ruby -y"
  }
}

resource "null_resource" "install_sinatra" {
  depends_on = [null_resource.install_ruby]

  provisioner "local-exec" {
    command = "gem install sinatra"
    
  }
}

resource "null_resource" "install_aquarium" {
  depends_on = [null_resource.install_ruby]

  provisioner "local-exec" {
    command = "gem install aquarium"
    
  }
}

resource "null_resource" "run_app" {
  depends_on = [null_resource.install_sinatra]
  

  provisioner "local-exec" {
    command     = "ruby appAspectos.rb"
    working_dir = path.module
  }
}
