resource "aws_key_pair" "my_key_pair" {
  key_name   = "id_rsa"
  public_key = file("id_rsa.pub")
}


resource "aws_instance" "elb_instance_example1" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.elb_sg.id]

  # key name
  key_name = aws_key_pair.my_key_pair.key_name

  user_data = <<EOF

	EOF

  tags = {
    Name = "EC2-Instance-1"
  }
}

resource "aws_instance" "elb_instance_example2" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.elb_sg.id]

  # key name
  key_name = aws_key_pair.my_key_pair.key_name

  user_data = <<EOF

	EOF

  tags = {
    Name = "EC2-Instance-1"
  }
}

output "ec2_example1_ip" {
  description = "The DNS name of the ELB"
  value       = aws_instance.elb_instance_example1.public_ip
}

output "ec2_example2_ip" {
  description = "The DNS name of the ELB"
  value       = aws_instance.elb_instance_example2.public_ip
}
