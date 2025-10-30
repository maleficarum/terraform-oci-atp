data "vault_generic_secret" "atp_password" {
  path = "${var.client}/${var.application_name}/${var.environment}/atp"
}