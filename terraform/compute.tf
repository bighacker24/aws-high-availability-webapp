data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_launch_template" "app" {
  name_prefix            = "ha-web-app-"
  image_id               = nonsensitive(data.aws_ssm_parameter.al2023.value)
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.app.id]
  update_default_version = true
  user_data              = filebase64("${path.module}/user_data.sh")

  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 8
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "ha-web-app"
      Project   = "aws-high-availability-webapp"
      ManagedBy = "terraform"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name      = "ha-web-app-root"
      Project   = "aws-high-availability-webapp"
      ManagedBy = "terraform"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                      = "ha-web-app-asg"
  min_size                  = 0
  max_size                  = 4
  desired_capacity          = var.app_desired_capacity
  vpc_zone_identifier       = [for name, s in aws_subnet.this : s.id if local.subnets[name].tier == "app"]
  health_check_type         = "EC2"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
