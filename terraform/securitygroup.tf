resource "aws_security_group" "GS-SG-ADM" {
  name        = "GS-SG-ADM"
  description = "GS-SG-ADM"
  vpc_id      = aws_vpc.GS-vpc.id

  ingress {
    description = "Allow SSH from External"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow out Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "GS-SG-RPROXY" {
  name        = "GS-SG-RPROXY"
  description = "GS-SG-RPROXY"
  vpc_id      = aws_vpc.GS-vpc.id

  ingress {
    description = "Allow SSH from Admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.GS-SG-ADM.id]
  }

  ingress {
    description = "Allow HTTP from External"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow out Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "GS-SG-WEB" {
  name        = "GS-SG-WEB"
  description = "GS-SG-WEB"
  vpc_id      = aws_vpc.GS-vpc.id

  ingress {
    description = "Allow SSH from Admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.GS-SG-ADM.id]
  }

  ingress {
    description = "Allow HTTP from Reverse Proxy"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.GS-SG-RPROXY.id]
  }

 ingress {
    description = "Allow SSH 10.0.0.0/16"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }


  egress {
    description = "Allow out Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "GS-SG-MYSQL" {
  name        = "GS-SG-MYSQL"
  description = "Allow MySQL access"
  vpc_id      = aws_vpc.GS-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  security_groups = [
    aws_security_group.GS-SG-WEB.id
]
  }

 ingress {
    description = "Allow SSH 10.0.0.0/16"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "GS-SG-ANSIBLE" {
  name        = "GS-SG-ANSIBLE"
  description = "GS-SG-ANSIBLE"
  vpc_id      = aws_vpc.GS-vpc.id

  ingress {
    description = "Allow SSH from ANSIBLE"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.GS-SG-WEB.id]
  }

  egress {
    description = "Allow out Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
