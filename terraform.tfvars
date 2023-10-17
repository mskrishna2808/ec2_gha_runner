instance_type       = "t2.micro"
key_pair_name       = "lab_keypair"
iam_instance_role   = "IamInstanceRole"
vpc_zone_identifier = ["subnet-0829fbc8bbc0f3b34"]
ami_owner           = ["amazon"]
user_data           = ["user_data_1.sh", "user_data_1.sh"]
runner_name         = ["runner-1"]