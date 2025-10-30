resource "oci_identity_compartment" "atp_compartment" {
  count = var.compartment_id != "" ? 1 : 0

  compartment_id = var.compartment_id
  description    = "Compartment for compute resources"
  name           = "compute"
}


resource "oci_database_autonomous_database" "adb" {
  # Required parameters
  #compartment_id           = oci_identity_compartment.atp_compartment.id
  compartment_id = local.compartment_id
  db_name        = var.instance_configuration.db_name
  display_name   = var.instance_configuration.display_name
  admin_password = data.vault_generic_secret.atp_password.data["password"]
  compute_model  = var.instance_configuration.compute_model
  #cpu_core_count           = var.instance_configuration.capacity.ocpus
  compute_count            = var.instance_configuration.capacity.ocpus
  data_storage_size_in_tbs = var.instance_configuration.capacity.data_storage_size_in_tbs
  db_workload              = var.instance_configuration.db_workload
  subnet_id                = var.subnet

  # Optional but recommended parameters
  is_auto_scaling_enabled = var.instance_configuration.is_auto_scaling_enabled
  license_model           = var.instance_configuration.license_model
  is_free_tier            = var.instance_configuration.is_free_tier
  db_version              = var.instance_configuration.db_version
  private_endpoint_label  = var.instance_configuration.private_endpoint_label

  freeform_tags = var.instance_configuration.freeform_tags
}