# M24 Lab 
#EC2 Instance
resource "aws_instance" "webserver" {
  ami           = "ami-0c4f7023847b90238"
  instance_type = "t2.micro"
  tags = {
      Name = "webserver"
      Description = "An Nginx WebServer on Ubuntu"
  }

  # user data
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    systemctl enable nginx
    systemctl start nginx
  EOF
  # key
  key_name = aws_key_pair.webkey.id
  # security group
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

# key
resource "aws_key_pair" "webkey" {
    key_name = "webkey"
    public_key = file("~/.ssh/webkey.pub")
}

# security group
resource "aws_security_group" "ssh-access" {
  name = "ssh-access"
  description = "Allow SSH access from Internet"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # https://www.whatsmyip.org/
  }
}

# public IP@
output publicip {
  value = aws_instance.webserver.public_ip
}



