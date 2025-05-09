resource "aws_subnet" "GS-pub" {
  vpc_id     = aws_vpc.GS-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "GS-pub"
  }
}

resource "aws_subnet" "GS-priv1" {
  vpc_id     = aws_vpc.GS-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "GS-priv1"
  }
}

resource "aws_subnet" "GS-priv2" {
  vpc_id     = aws_vpc.GS-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  
   tags = {
    Name = "GS-priv2"
  }
}

resource "aws_subnet" "GS-priv3" {
  vpc_id     = aws_vpc.GS-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "GS-priv3"
  }
}

resource "aws_subnet" "GS-ansible" {
  vpc_id     = aws_vpc.GS-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "GS-ansible"
  }
}

resource "aws_subnet" "GS-MYSQL" {
  vpc_id     = aws_vpc.GS-vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "GS-MYSQL"
  }
}
