locals {
  # Determine compartment ID with validation
  compartment_id = var.existing_compartment != "" ? var.existing_compartment : var.compartment_id

}