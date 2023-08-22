# Below code will fetch the latest AMI from the AWS

data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }

  owners = var.ami_owner # Replace with your desired owner(s) if needed
}
