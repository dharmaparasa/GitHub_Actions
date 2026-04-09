resource "aws_instance" "name" {
    instance_type = "t3.micro"
    ami = "ami-02dfbd4ff395f2a1b"
    tags = {
      Name="Dharma"
    }
}

output "public_ip" {
  value = aws_instance.name.public_ip
}