resource "aws_instance" "this" {
    count = var.instance_count # The number of instances to create
    ami = var.ami_id
    instance_type = var.instance_type # The type of instance to create
    key_name = var.key_name # The name of the key pair to use for SSH access
    subnet_id = element(var.subnet_ids, count.index % length(var.subnet_ids)) # The ID of the subnet to launch the instance in
    vpc_security_group_ids = [var.security_group_id] # The ID of the security group to associate with the instance

    tags = {
        Name = "ec2-instance-${var.environment}" # The name of the EC2 instance
        Environment = var.environment # The environment for the EC2 instance
        Project = var.project_name # The name of the project
        Owner = var.owner # The owner of the project
    }
    user_data = var.user_data
}