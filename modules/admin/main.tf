resource "aws_instance" "admin" {
  ami               = data.aws_ami.app_ami.id
  instance_type     = var.instance_type
  security_groups   = ["${var.sg_name}"]
  key_name          = var.key_name
  availability_zone = "us-east-1a"
  user_data         = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                EOF

  tags = {
    Name = "capge-test-admin"
    iac  = "terraform"
    company = "icgroup"
  }

  root_block_device {
    delete_on_termination = true
  }
}