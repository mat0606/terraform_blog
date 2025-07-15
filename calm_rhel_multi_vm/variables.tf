variable "user" {
  type = string
}

variable "password" {
  type = string
}
variable "endpoint" {
  type = string
}
variable "port" {
  type = string
}

variable "bp_name" {
  type = string
}
variable "app_name" {
  type = string
}
variable "app_description" {
  type      = string
}

# Not implemented in Terraform 2.2.0
#variable "application_profile"{
#  type = string
#}

variable "substrate_config" {
  type = string
  default = <<EOF
  {
   "spec": {
      "name": "r@@{calm_time}@@",
      "resources": {
         "memory_size_mib": 3072,
         "num_sockets": 2,
         "num_vcpus_per_socket": 1
      }
   }
  }
EOF 
}