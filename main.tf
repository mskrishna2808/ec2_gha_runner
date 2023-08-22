resource "aws_launch_template" "asg_lt_runner" {
  count         = length(var.runner_name)
  name          = "${var.runner_name[count.index]}-asg-gha-runner"
  image_id      = data.aws_ami.latest.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  user_data     = filebase64(var.user_data[count.index])

  iam_instance_profile {
    name = var.iam_instance_role
  }

  network_interfaces {
    associate_public_ip_address = true
  }
}

resource "aws_autoscaling_group" "asg_runner" {
  count               = length(var.runner_name)
  name                = "${var.runner_name[count.index]}-runner-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = var.vpc_zone_identifier

  launch_template {
    id      = aws_launch_template.asg_lt_runner[count.index].id
    version = "$Latest"
  }

  tag {

    key                 = "Name"
    value               = "${var.runner_name[count.index]}-runner"
    propagate_at_launch = true
  }
  tag {
    key                 = "Provisioned by"
    value               = "Terraform"
    propagate_at_launch = true
  }

}