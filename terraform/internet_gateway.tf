resource "aws_internet_gateway" "GS-igw" {
  vpc_id = aws_vpc.GS-vpc.id

  tags = {
    Name = "GS-igw"
  }
}
