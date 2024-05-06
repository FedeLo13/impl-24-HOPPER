
# main.tf

provider "null" {}

resource "null_resource" "install_ruby" {
  provisioner "local-exec" {
    command = "brew install ruby && echo 'export PATH=/usr/local/Cellar/ruby/2.4.1_1/bin:$PATH' >> ~/.zprofile"
  }
}

resource "null_resource" "install_sinatra" {
  depends_on = [null_resource.install_ruby]

  provisioner "local-exec" {
    command = "brew install brew-gem && brew gem install sinatra"
  }
}

resource "null_resource" "run_app" {
  depends_on = [null_resource.install_sinatra]

  provisioner "local-exec" {
    command = "ruby app.rb"
    working_dir = "${path.module}" 
  }
}