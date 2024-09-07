resource "aws_instance" "web-server" {
  count = var.web_server_count

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web-server.id]
  subnet_id                   = module.vpc.private_subnets[count.index]
  associate_public_ip_address = true

  user_data = <<-EOF
            #!/bin/bash
            apt-get update
            apt-get install -y apache2
            echo "Hello from web-server ${count.index + 1}" > /var/www/html/index.html
            echo "Web Server ${count.index + 1}" > /var/www/html/health
            EOF

  tags = {
    Name      = "Web Server ${count.index + 1}"
    Terraform = true
  }
}


