# EC2 Instance

# Resource Block
resource "aws_instance" "ec2demo" {
  #ami                    = data.aws_ami.amazon_linux.id
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.aws_instance_type
  user_data              = file("${path.module}/app-installs.sh")
  key_name               = var.aws_key_pair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 30
    delete_on_termination = true
    encrypted             = true

    tags = {
      Name = "ubuntu-root-volume"
    }
  }
}

