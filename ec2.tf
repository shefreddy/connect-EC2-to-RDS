resource "aws_instance" "web_server" {
  ami                         = "ami-0f88e80871fd81e91" # Replace with your desired AMI
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "WebServer"
  }

  # User data script to install httpd, php, mysql and wordpress
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              sudo yum install wget httpd mysql php php-mysql -y
              sudo wget https://wordpress.org/latest.tar.gz
              sudo tar -xzf latest.tar.gz
              sudo cp -r wordpress/* /var/www/html
              sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
              sudo cd /var/www/html
              sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
              sudo chown -R apache:apache /var/www/html
              sudo systemctl start httpd 
              sudo systemctl enable httpd

              EOF
}