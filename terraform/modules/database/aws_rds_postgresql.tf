#
# AWS RDS PostgreSQL Resources
#  * Security Group to allow networking traffic with EKS cluster
#  * RDS
#

resource "aws_security_group" "revolut-app-db" {
  name        = "rds-revolut-app-db"
  description = "EKS communication with database"
  vpc_id      = "${var.aws_vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-revolut-app-db"
  }
}

resource "aws_security_group_rule" "revolut-app-db-ingress" {
  description              = "Allow pods to communicate with database server"
  from_port                = 5432
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.revolut-app-db.id}"
  source_security_group_id = "${var.aws_security_group_node_id}"
  to_port                  = 5432
  type                     = "ingress"
}


module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "revolut-app-db"

  engine            = "postgres"
  engine_version    = "9.6.9"
  instance_class    = "db.t3.micro"
  allocated_storage = 5
  storage_encrypted = false

  # XXX: kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  name = "revolut_production"
  username = "revolutapp"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "5432"

  vpc_security_group_ids = ["${aws_security_group.revolut-app-db.id}"]

  maintenance_window = "Mon:02:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    Owner       = "revolut-app"
    Environment = "production"
  }

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # DB subnet group
  subnet_ids = ["${aws_subnet.revolut-app-db.*.id}"]

  # DB parameter group
  family = "postgres9.6"

  # DB option group
  major_engine_version = "9.6"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "revolut-app-db"

  # Database Deletion Protection
  deletion_protection = true
}
