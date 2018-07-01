# Region

variable "region" {
  description = "The AWS region to create things in"
  default     = "us-west-2"
}

# Instances

variable "total_instances" {
  default = 3
}

# Ubuntu 16.04 LTS

variable "instance_ami" {
  description = "Amazon linux AMI"
  default     = "ami-db710fa3"
}

variable "instance_prefix" {
  description = "Name to instance"
  default     = "mongo-"
}

variable "instance_type" {
  description = "Instance AWS type"
  default     = "t2.micro"
}

variable "instance_user" {
  description = "Instance user to use into instance"
  default     = "ubuntu"
}

# Key Pair Name

variable "key_name" {
  description = "Value to key pair created in AWS"
  default     = "andrescolonia_key"
}

variable "private_key" {
  description = "Key to connect into instance to run script"
  default     = "/Users/andres/.ssh/id_rsa"
}

# Vpc

variable "vpc_id" {
  description = "Mongo VPC"
  default     = "vpc-e62a249f"
}

# Subnet
variable "subnet_ids" {
  type = "map"

  default = {
    "us-west-1" = "subnet-e4ea899d"
    "us-west-2" = "subnet-6a8d0121"
    "us-west-3" = "subnet-fdacd4a7"
  }
}

# Security Group

variable "cidr_blocks" {
  default     = "0.0.0.0/0"
  description = "CIDR for sg"
}

variable "sg_name" {
  default     = "mongo security group"
  description = "Security Group to MongoDB"
}
