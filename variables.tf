variable "compartment_id" {
  type        = string
  description = "The target compartment ID to create an ATP specific compartment"
  default     = ""
}

variable "existing_compartment" {
  type        = string
  default     = ""
  description = "The existing compartment where the network resources should be created. If this si set, the compartment_id variable should be empty"
}

variable "subnet" {
  type        = string
  description = "The subnet (OCID) to deploy the ATP instance"
}

variable "instance_configuration" {
  description = "The instance configuration params for ATP"
  type = object({
    db_name       = string,
    display_name  = string,
    compute_model = string, # ECPU or OCPU
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
    freeform_tags = optional(map(string), {
      "OracleTags.CreatedBy"   = "default/terraform-cae",
      "OracleTags.Environment" = "general"
      "OracleTags.Application" = "landing-zone"
    }),
  })
}

variable "environment" {
  type        = string
  description = "The target environment"
}

variable "application_name" {
  type        = string
  description = "The application name to be deployed"
}

variable "vault_token" {
  type        = string
  description = "The token to access the vault"
  default     = ""
}

variable "vault_host" {
  type        = string
  description = "The vault host with port"
  default     = ""
}

variable "client" {
  type        = string
  description = "The customer name [ alpura, alianza, megacable]"
  default     = "generic"
}