resource "null_resource" "cluster" {
  count = length(aws_instance.public-server.*.public_ip)

  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("mumbai-key.pem")
      host        = element(aws_instance.public-server.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec"{
    inline = [
        "sudo chmod 700 /tmp/user-data.sh",
        "sudo /tmp/user data.sh",
        "sudo apt update",
        "sudo apt install jq unzip -y",
    ]
       
    connection {
        type  = "ssh"
        user = "ubuntu"
        private_key = file("mumbai-key.pem")
        host = element(aws_instance.public-server.*.public_ip, count.index)
    }

  }
}
