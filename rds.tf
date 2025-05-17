resource "aws_db_instance" "rds_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.36"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = "password123" # Change this to a more secure password
  identifier             = "my-rds-instance"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
  multi_az               = false
  publicly_accessible    = true
  tags = {
    Name = "MyRDSInstance"
  }
}

resource "aws_db_subnet_group" "main" {
  name        = "main-db-subnet-group"
  subnet_ids  = module.vpc.private_subnets
  description = "Main DB Subnet Group"
  tags = {
    Name = "DB Subnet Group"
  }
}