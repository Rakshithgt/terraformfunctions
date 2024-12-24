resource "aws_instance" "private-server" {
  # count = length(var.private_cidr_block)
  count = var.environment == "QA" ? 3 : 1
  ami = lookup(var.amis, var.aws_region)
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = element(aws_subnet.private_subnet.*.id, count.index + 1)
  vpc_security_group_ids = [aws_security_group.allow_all.id]
#   associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-private-server-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx git
    git clone https://github.com/saikiranpi/SecOps-game.git /tmp/SecOps-game
    sudo rm -f /var/www/html/index.nginx-debian.html
    sudo cp /tmp/SecOps-game/index.html /var/www/html/index.html
    echo "<h1>${var.vpc_name}-public-server-${count.index + 1}</h1>" >> /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}


