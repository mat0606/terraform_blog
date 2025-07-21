terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "2.3.0"
    }
  }
}

provider "nutanix" {
  username     = var.user
  password     = var.password
  endpoint     = var.endpoint
  port         = var.port
  insecure     = true
  wait_timeout = 10
}

data "nutanix_blueprint_runtime_editables" "example" {
    bp_name = var.bp_name
}

# dumps read value into a readable json file
resource "local_file" "dump_runtime_value" {
    content  = jsonencode(data.nutanix_blueprint_runtime_editables.example.runtime_editables)
    filename = "runtime_value.json"
}



# Launch blueprint and provision your application
resource "nutanix_self_service_app_provision" "test" {
   bp_name         = var.bp_name
   app_name        = var.app_name
   app_description = var.app_description
#   application_profile     = var.app_profile Not implemented in Terraform 2.2.0
#   action          = "stop"
#   patch_name      = var.patch_name
#   config_name     = var.config_name

  runtime_editables {
      substrate_list {
         name= "WindowsVM"
         value = var.substrate_config
       }
    }
}