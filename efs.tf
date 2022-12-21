resource "aws_efs_file_system" "default-efs" {
  creation_token = "default-efs"
}

resource "aws_efs_mount_target" "efs-mt" {
  file_system_id  = aws_efs_file_system.default-efs.id
  subnet_id       = data.aws_subnet.ue1a-subnet.id
  security_groups = [aws_security_group.sg1.id]
}
