resource "aws_nat_gateway" "GS-natgw" {
  subnet_id     = aws_subnet.GS-pub.id
  allocation_id = aws_eip.GS-nateip.id

  tags = {
    Name = "GS-natgw"
  }
}
