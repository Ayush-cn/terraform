
variable "instance_name" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "key_name" {}

resource "aws_instance" "this" {
  ami                         = "ami-0fe8bec493a81c7da"
  instance_type               = "t3.large"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = var.instance_name
  }
}

output "public_ip" {
  value = aws_instance.this.public_ip
}
