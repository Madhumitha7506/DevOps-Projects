resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.environment}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "main" {
  identifier            = "${var.environment}-database"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = "default.mysql8.0"
  skip_final_snapshot   = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : [var.db_security_group_id]

  backup_retention_period = 1
  backup_window           = "03:00-04:00"
  maintenance_window      = "Sun:04:00-Sun:05:00"

  storage_encrypted = true

  tags = {
    Name        = "${var.environment}-database"
    Environment = var.environment
  }
}