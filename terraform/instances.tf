resource "aws_instance" "GS-INSTANCE-MYSQL" {
  key_name                 = aws_key_pair.admin.key_name
  ami                      = "ami-084568db4383264d4"
  security_groups          = [aws_security_group.GS-SG-MYSQL.id]
  subnet_id                = aws_subnet.GS-MYSQL.id
  instance_type            = "t2.micro"

  tags = {
    Name = "GS-INSTANCE-MYSQL"
  }
}

resource "aws_instance" "GS-INSTANCE-ADM" {
  key_name                 = aws_key_pair.admin.key_name
  ami                      = "ami-084568db4383264d4"
  security_groups          = [aws_security_group.GS-SG-ADM.id]
  subnet_id                = aws_subnet.GS-pub.id
  instance_type            = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Name = "GS-INSTANCE-ADM"
  }
}

resource "aws_instance" "GS-INSTANCE-RPROXY" {
  key_name                 = aws_key_pair.admin.key_name
  ami                      = "ami-084568db4383264d4"
  security_groups          = [aws_security_group.GS-SG-RPROXY.id]
  subnet_id                = aws_subnet.GS-pub.id
  instance_type            = "t2.micro"
  associate_public_ip_address = true
  
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
	      rm /etc/nginx/sites-enabled/default


              cat > /etc/nginx/conf.d/load-balancer.conf <<EOL
              upstream backend {
                  server ${aws_instance.GS-INSTANCE-WEB1.private_ip};
                  server ${aws_instance.GS-INSTANCE-WEB2.private_ip};
                  server ${aws_instance.GS-INSTANCE-WEB3.private_ip};
              }

              server {
                  listen 80;

                  location / {
                      proxy_pass http://backend;
                      proxy_set_header Host \$host;
                      proxy_set_header X-Real-IP \$remote_addr;
                      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                      proxy_set_header X-Forwarded-Proto \$scheme;
                  }
              }
              EOL

              systemctl restart nginx
              EOF

  tags = {
    Name = "GS-INSTANCE-RPROXY"
  }
}


resource "aws_instance" "GS-INSTANCE-WEB1" {
  key_name        = aws_key_pair.admin.key_name
  ami             = "ami-084568db4383264d4"
  security_groups = [aws_security_group.GS-SG-WEB.id]
  subnet_id       = aws_subnet.GS-priv1.id
  instance_type   = "t2.micro"

  tags = {
    Name = "GS-INSTANCE-WEB1"
  }
}

resource "aws_instance" "GS-INSTANCE-WEB2" {
  key_name        = aws_key_pair.admin.key_name
  ami             = "ami-084568db4383264d4"
  security_groups = [aws_security_group.GS-SG-WEB.id]
  subnet_id       = aws_subnet.GS-priv2.id
  instance_type   = "t2.micro"

  tags = {
    Name = "GS-INSTANCE-WEB2"
  }
}

resource "aws_instance" "GS-INSTANCE-WEB3" {
  key_name        = aws_key_pair.admin.key_name
  ami             = "ami-084568db4383264d4"
  security_groups = [aws_security_group.GS-SG-WEB.id]
  subnet_id       = aws_subnet.GS-priv3.id
  instance_type   = "t2.micro"

  tags = {
    Name = "GS-INSTANCE-WEB3"
  }
}

resource "aws_instance" "GS-INSTANCE-ANSIBLE" {
  key_name        = aws_key_pair.admin.key_name
  ami             = "ami-084568db4383264d4"
  security_groups = [aws_security_group.GS-SG-WEB.id]
  subnet_id       = aws_subnet.GS-ansible.id
  instance_type   = "t2.micro"

  tags = {
    Name = "GS-INSTANCE-ANSIBLE"
  }
}
