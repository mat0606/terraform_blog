terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "2.3.1" # or your pinned version
    }
  }
}

provider "nutanix" {
  endpoint = var.pc_endpoint   # e.g., "10.0.0.10"
  username = var.pc_username
  password = var.pc_password
  port = var.pc_port
  insecure = true              # if you use self-signed certs
}

# -------------------------------------------------
# Get all VPCs
# -------------------------------------------------
data "nutanix_vpcs_v2" "list_vpcs" {}

# Normalize VPC objects you want to consume later
locals {
  normalized_vpcs = [
    for v in data.nutanix_vpcs_v2.list_vpcs.vpcs : {
      id           = v.metadata.uuid
      name         = v.spec.name
      vpc_type     = try(v.status.resources.vpcType, null)
      # Ensure this is always a LIST
      category_ids = try(
        tolist(v.metadata.category_ids),
        []
      )
    }
  ]
}

output "normalized_vpcs" {
  value = local.normalized_vpcs
}


#output "all_vpcs" {
#  value = [
#    for v in data.nutanix_vpcs_v2.list_vpcs.vpcs : {
#      name = try(v.spec.name, null)
#      id   = try(v.ext_id, try(v.metadata.uuid, null))
#      type = try(v.spec.resources.vpc_type, null)
#    }
#  ]
#}

# -------------------------------------------------
# Get all VPCs with filter
# -------------------------------------------------
#data "nutanix_vpcs_v2" "list_vpcs_with_filter" {
#  filter = "vpcType eq 'VLAN'"
#}

#output "filtered_vpcs_vlan" {
#  value = [
#    for v in data.nutanix_vpcs_v2.list_vpcs_with_filter.vpcs : {
#      name = try(v.spec.name, null)
#      id   = try(v.ext_id, try(v.metadata.uuid, null))
#      type = try(v.spec.resources.vpc_type, null)
#    }
#  ]
#}

# -------------------------------------------------
# Get all VPCs with order_by, limit, and filter
# -------------------------------------------------
#data "nutanix_vpcs_v2" "list_vpcs_with_order_by_limit_filter" {
#  filter   = "vpcType eq 'VLAN'"
#  order_by = "name desc"
#  limit    = 10
#}

#output "filtered_ordered_limited_vpcs" {
#  value = [
#    for v in data.nutanix_vpcs_v2.list_vpcs_with_order_by_limit_filter.vpcs : {
#      name = try(v.spec.name, null)
#      id   = try(v.ext_id, try(v.metadata.uuid, null))
#      type = try(v.spec.resources.vpc_type, null)
#    }
#  ]
#}
