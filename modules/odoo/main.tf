resource "aws_instance" "odoo" {
  ami               = data.aws_ami.app_ami.id
  instance_type     = var.instance_type
  security_groups   = ["${var.sg_name}"]
  key_name          = var.key_name
  availability_zone = "us-east-1a"
  user_data         = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install python3-pip
                sudo pip3 install ansible
                sudo apt-get install sshpass -y
                ansible-galaxy install lianhuahayu.docker_role
                ansible-galaxy install lianhuahayu.odoo_role
                ansible-playbook -i /home/ubuntu/.ansible/roles/lianhuahayu.odoo_role/tests/inventory /home/ubuntu/.ansible/roles/lianhuahayu.odoo_role/tests/playbook_test.yml --private-key "~/.ssh/id_rsa"
                EOF
  tags = {
    Name    = "capge-test-odoo"
    iac     = "terraform"
    company = "icgroup"
  }

  root_block_device {
    delete_on_termination = true
  }
}