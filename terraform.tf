resource "aws_instance" "name" {
    instance_type = "t3.micro"
    ami = "ami-03caad32a158f72db"
    tags = {
      Name="Dharma"
    }
    key_name = "dkp"
    subnet_id = "subnet-08fbc8f0db1f0486f"
}


output "public_ip" {
  value = aws_instance.name.public_ip
}