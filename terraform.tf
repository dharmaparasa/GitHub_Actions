#Create VPC etc
#Create a keypair in same region as in provider
#change subnet, vpcid and keypair name in the code

resource "aws_security_group" "name" {
    name = "DharmaSG"

    vpc_id = "vpc-0a0653a840184508e"
    dynamic "ingress" {
      for_each = [
        for port,cidr in {
          22 = "0.0.0.0/0" }:{
          from_port=port
          to_port=port
          cidr_blocks=[cidr]
          protocol="tcp"
        }
      ]
      content {
          from_port   = ingress.value.from_port
          to_port     = ingress.value.to_port
          protocol    = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_blocks
      }
    }

    egress {
        from_port = 0
        to_port= 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}




#=================================================================

resource "aws_instance" "name" {
    instance_type = "t3.micro"
    ami = "ami-03caad32a158f72db"
    tags = {
      Name="Dharma"
    }
    key_name = "pdl"
    
    #mention for another region
    subnet_id = "subnet-0b654b6b7c4b61498"
    security_groups = [aws_security_group.name.id]
    associate_public_ip_address = true
}


output "public_ip" {
  value = aws_instance.name.public_ip
}