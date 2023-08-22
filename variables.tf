variable "iam_instance_role" {
  description = "IAM role to attach to the ec2 instance"
  default     = {}
}

variable "instance_type" {
  description = "Instance type for GH Actions runner"
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Key pair name to ssh into ec2 instance"
  default     = {}
}

variable "vpc_zone_identifier" {
  description = "Subnets information to create ec2 instances"
  default     = {}
}

variable "ami_owner" {
  description = "Owner name or Account number to fetch the latest AMI"
  default     = {}
}

variable "user_data" {
  type = list(string)
  description = "User data for the ec2 instance"
}

variable "runner_name" {
  type = list(string)
  description = "ec2 instance name"
}