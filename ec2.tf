resource "aws_key_pair" "ec2-keypair" {
  # run "ssh-keygen -t ed25519 -C "erfangc@gmail.com"" and replace the public key portion below with what's generated
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIx0pUGg4Z0nPH1Bx4DYs2BrW2Jr7arz4tzacwV4D2Zf erfangc@gmail.com"
}

resource "aws_instance" "server1" {
  key_name               = aws_key_pair.ec2-keypair.key_name
  ami                    = "ami-0b5eea76982371e91"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  instance_type          = "t3.medium"
  subnet_id              = data.aws_subnet.ue1a-subnet.id
  user_data              = templatefile("${path.module}/mount.sh.tpl", {
    dns_name : aws_efs_file_system.default-efs.dns_name
  } )
  depends_on = [aws_efs_mount_target.efs-mt]

  tags = {
    Name      = "Server"
    Terraform = "true"
  }
}

resource "aws_instance" "server2" {
  key_name               = aws_key_pair.ec2-keypair.key_name
  ami                    = "ami-0b5eea76982371e91"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  instance_type          = "t3.medium"
  subnet_id              = data.aws_subnet.ue1a-subnet.id
  user_data              = templatefile("${path.module}/mount.sh.tpl", {
    dns_name : aws_efs_file_system.default-efs.dns_name
  } )
  depends_on = [aws_efs_mount_target.efs-mt]

  tags = {
    Name      = "Server"
    Terraform = "true"
  }
}

output "instances-ips1" {
  value = aws_instance.server1.public_ip
}

output "instances-ips2" {
  value = aws_instance.server2.public_ip
}
