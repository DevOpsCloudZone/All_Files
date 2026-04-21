variable "instance_type"{
 description ="Ec2_instance_type"
 type = string
}
variable "availability_zone"{
 description ="availability_zones_mumbai"
 type = string
}
variable "volume_size"{
description ="EBS_size"
type = number
}
variable "ec2_instance_name"{
  description ="EC2 Instance created through variables "
  type = string
}

