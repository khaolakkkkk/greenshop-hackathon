resource "aws_eip" "GS-nateip" {
  allocation_id = aws_eip.GS-nateip.id
  subnet_id     = aws_subnet.public.id
}
