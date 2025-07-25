variable "compartment_id" {
  type        = string
  description = "The target compartment ID to create an ATP specific compartment"
}

variable "instance_configuration" {
  type = object({
    db_name      = string,
    display_name = string,
    capacity = object({
      ocpus                    = number,
      data_storage_size_in_tbs = number
    })
    db_workload             = string, #"OLTP" or "DW" for Data Warehouse
    is_auto_scaling_enabled = bool,
    license_model           = string, #"LICENSE_INCLUDED" or "BRING_YOUR_OWN_LICENSE"
    is_free_tier            = bool,
    db_version              = string,
    private_endpoint_label  = string #"adbprivate"  Required for private endpoint
  })
}

variable "environment" {
  type        = string
  description = "The target environment"
}

variable "db_admin_password" {
  type        = string
  description = "The admin password"
  sensitive   = true
}

variable "application_name" {
    type = string
    description = "The application name to be deployed"
}

variable "subnet" {
    type = string
    description = "The subnet (OCID) to deploy the ATP instance"
}