resource "aws_route_table_association" "GS-privrtb-assoc1" {
  route_table_id = aws_route_table.GS-privrtb.id
  subnet_id      = aws_subnet.GS-priv1.id
}

resource "aws_route_table_association" "GS-privrtb-assoc2" {
  route_table_id = aws_route_table.GS-privrtb.id
  subnet_id      = aws_subnet.GS-priv2.id
}

resource "aws_route_table_association" "GS-privrtb-assoc3" {
  route_table_id = aws_route_table.GS-privrtb.id
  subnet_id      = aws_subnet.GS-priv3.id
}

resource "aws_route_table_association" "GS-privrtb-assoc4" {
  route_table_id = aws_route_table.GS-privrtb.id
  subnet_id      = aws_subnet.GS-ansible.id
}


resource "aws_route_table_association" "GS-privrtb-assoc5" {
  route_table_id = aws_route_table.GS-privrtb.id
  subnet_id      = aws_subnet.GS-MYSQL.id
}


