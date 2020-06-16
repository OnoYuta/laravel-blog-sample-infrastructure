# apply後にElastic IPのパブリックIPを出力する
output "public_ip" {
  value = aws_eip.elastic-ip.public_ip
}