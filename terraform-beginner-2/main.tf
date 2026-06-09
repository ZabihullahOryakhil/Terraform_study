data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}




resource "aws_security_group" "web_sg" {
  name = "web-server-sg-${var.environment}"


  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg-${var.environment}"
  }
}


resource "aws_instance" "web" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "web-${var.environment}"
    Env = var.environment
  }


  user_data = <<-EOT
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              rm -f /var/www/html/index.html
              echo "<h1>Hello Abdul Munir <strong>Miasi</strong></h1>" > /var/www/html/index.html
              EOT

  lifecycle {
    create_before_destroy = false
    ignore_changes = [ tags ]
  }
}