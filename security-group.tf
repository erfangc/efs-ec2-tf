
resource "aws_security_group" "sg1" {
  name   = "server"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "allow-ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.sg1.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow-vpc-ingress" {
  from_port         = 0
  protocol          = "tcp"
  security_group_id = aws_security_group.sg1.id
  to_port           = 63200
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  type              = "ingress"
}

resource "aws_security_group_rule" "allow-vpc-egress" {
  from_port         = 0
  protocol          = "tcp"
  security_group_id = aws_security_group.sg1.id
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  to_port           = 63200
  type              = "egress"
}
