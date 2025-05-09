resource "tls_private_key" "admin" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "admin" {
  key_name   = "admin"
  public_key = tls_private_key.admin.public_key_openssh
}

output "private_key_pem" {
  value     = tls_private_key.admin.private_key_pem
  sensitive = true
}
