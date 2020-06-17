resource "aws_instance" "app" {
  ami                         = "ami-0471ea40c46b4325d"
  instance_type               = "t2.micro"
  monitoring                  = true
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance_profile.name
  subnet_id                   = aws_subnet.public_subnet_1.id
  user_data                   = file("user_data.sh")
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web.id]
  key_name                    = aws_key_pair.key_pair.id

  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
  }

  tags = {
    Name = "${var.project_name}-app"
  }
}

resource "aws_eip" "elastic-ip" {
  instance = aws_instance.app.id
  vpc      = true
}