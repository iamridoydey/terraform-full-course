
#1: Create before destroy
# resource "aws_instance" "prite_instance" {
#   ami = var.aws_ami_list.ubuntu
#   instance_type = var.instance_type_list.micro
#   tags = var.meta_tag_args[0]

#   lifecycle {
#     create_before_destroy = true
#   }
# }



#2: Prevent destroy
# resource "aws_s3_bucket" "prite_bucket" {
#   bucket = "iamridoydey-${var.tags.Name}-bucket"

#   # lifecycle {
#   #   prevent_destroy = true
#   # }
# }


#3: Ignore changes
# resource "aws_launch_template" "prite_launch_template" {
#   name_prefix   = "prite"
#   image_id      = var.aws_ami_list.ubuntu
#   instance_type = var.instance_type_list.small
# }


# resource "aws_autoscaling_group" "prite_autoscaling_group" {
#   availability_zones = var.availability_zones
#   desired_capacity   = 2
#   max_size           = 3
#   min_size           = 1

#   launch_template {
#     id = aws_launch_template.prite_launch_template.id
#     version = "$Latest"
#   }

#   tag {
#     key                 = "Name"
#     value               = var.tags.Name
#     propagate_at_launch = true
#   }

#   tag {
#     key                 = "Name"
#     value               = var.tags.Name
#     propagate_at_launch = false
#   }

#   lifecycle {
#     ignore_changes = [ desired_capacity, min_size ]
#   }
# }


#4: Replace by trigger
# Security group
# resource "aws_security_group" "prite_sg" {
#   name        = "prite-security-group"
#   description = "Allow inbound and outbound traffic to ec2"

#   ingress {
#     self        = true
#     from_port   = 80
#     protocol    = "tcp"
#     to_port     = 80
#     description = "Allow HTTP from anywhere"
#   }

#   ingress {
#     self        = true
#     from_port   = 443
#     protocol    = "tcp"
#     to_port     = 443
#     description = "Allow HTTPS from anywhere"
#   }

#   egress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Allow All Outbound traffic"
#   }
# }


# resource "aws_instance" "prite_instance" {
#   ami = var.aws_ami_list.ubuntu
#   instance_type = var.instance_type_list.micro
#   vpc_security_group_ids = [ aws_security_group.prite_sg.id ]

#   tags = var.meta_tag_args[0]

#   lifecycle {
#     replace_triggered_by = [ aws_security_group.prite_sg ]
#   }
# }



#5: Precondition
resource "aws_s3_bucket" "regional_validation" {
  bucket = "validated-regional-bucket-${local.env}-${local.region}"


  tags = merge(
    var.tags,
    {
      Name = "Region Validated Bucket"
      Demo = "precondition"
    }
  )


  lifecycle {
    precondition {
      condition = contains(var.available_region, local.region)
      error_message = "Please use region from the avilable region variable"
    }

    
  }
}


resource "aws_s3_bucket_public_access_block" "bucket_policy" {
  bucket = aws_s3_bucket.regional_validation.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true


  lifecycle {
    postcondition {
      condition = self.restrict_public_buckets
      error_message = "Bucket should be private"
    }
  }
}