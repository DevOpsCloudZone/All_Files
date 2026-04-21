output "ec2_public_ip"{
 description = "getting public Ip from EC2_instance"
 value=aws_instance.aws_demo.public_ip
 }

