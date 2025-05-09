resource "aws_route_table" "GS-privrtb" {
  vpc_id = aws_vpc.GS-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.GS-natgw.id
  }
}
