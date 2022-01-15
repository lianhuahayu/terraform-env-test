module "admin" {
  source        = "../modules/Admin"
  instance_type = "t2.micro"
  sg_name       = "security_group_capge"
  key_name      = "capge_projet_kp"
  url_odoo      = module.odoo.odoo_pub_ip
  url_admin     = module.admin.admin_pub_ip
}

module "odoo" {
  source        = "../modules/Odoo"
  instance_type = "t2.micro"
  security_name = "security_group_capge"
  key_name      = "capge_projet_kp"
}
