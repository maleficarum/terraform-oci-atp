resource "oci_identity_compartment" "atp_compartment" {
  compartment_id = var.compartment_id
  description    = "Compartment for ATP resources"
  name           = "atp"
}

resource "oci_database_autonomous_database" "adb" {
  # Required parameters
  compartment_id           = oci_identity_compartment.atp_compartment.id
  db_name                  = var.instance_configuration.db_name
  display_name             = var.instance_configuration.display_name
  admin_password           = var.db_admin_password
  cpu_core_count           = var.instance_configuration.capacity.ocpus
  data_storage_size_in_tbs = var.instance_configuration.capacity.data_storage_size_in_tbs
  db_workload              = var.instance_configuration.db_workload
  subnet_id              = var.subnet
  
  # Optional but recommended parameters
  is_auto_scaling_enabled = var.instance_configuration.is_auto_scaling_enabled
  license_model           = var.instance_configuration.license_model
  is_free_tier            = var.instance_configuration.is_free_tier
  db_version              = var.instance_configuration.db_version
  #nsg_ids                 = [oci_core_network_security_group.adb_nsg.id]
  private_endpoint_label = var.instance_configuration.private_endpoint_label

  defined_tags = {
    "Oracle-Tags.CreatedBy"   = "default/terraform-cae",
    "Oracle-Tags.Environment" = var.environment
    "Oracle-Tags.Application" = var.application_name
  } 
}

terraform {
  required_version = ">=1.9.7"
  required_providers {

    oci = {
      source  = "oracle/oci"
      version = "~> 7.11.0"
    }

  }
}

provider "oci" {
  config_file_profile = "DEFAULT"
}