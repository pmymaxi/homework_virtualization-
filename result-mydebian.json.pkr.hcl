
source "yandex" "debian_docker_12" {
  disk_type           = "network-hdd"
  folder_id           = "###"
  image_description   = "my custom debian with docker"
  image_name          = "debian-12-my-docker"
  source_image_family = "debian-12"
  ssh_username        = "debian"
  subnet_id           = "###"
  token               = "###"
  use_ipv4_nat        = true
  zone                = "ru-central1-b"
}

build {
  sources = ["source.yandex.debian_docker_12"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ca-certificates curl",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc",
      "sudo chmod a+r /etc/apt/keyrings/docker.asc",
      "sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<'EOF'\nTypes: deb\nURIs: https://download.docker.com/linux/debian\nSuites: bookworm\nComponents: stable\nSigned-By: /etc/apt/keyrings/docker.asc\nEOF",
      "sudo apt-get update",
      "sudo apt-get install -y mc htop tmux",
      "sudo apt-get remove -y $(dpkg --get-selections | grep -E 'docker.io|docker-compose|docker-doc|podman-docker|containerd|runc' | cut -f1)",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
    ]
  }

}
