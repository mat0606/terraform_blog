terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "2.4.0" # or your pinned version
    }
  }
}

provider "nutanix" {
  username     = var.pc_username
  password     = var.pc_password
  endpoint     = var.pc_endpoint
  port         = var.pc_port
  insecure     = true
  wait_timeout = 10
}

resource "nutanix_virtual_machine_v2" "vm-3" {
  name                 = var.vm_name
  num_cores_per_socket = 1
  num_sockets          = 1
  cluster {
    ext_id = var.cluster_uuid
  }
  project {
    ext_id = var.project_uuid
  }

  disks {
    disk_address {
      bus_type = "SCSI"
      index    = 0
    }
    backing_info {
      vm_disk {
        data_source {
          reference {
            image_reference {
              image_ext_id = var.image_uuid
            }
          }
        }
        disk_size_bytes = 50 * pow(1024, 3) # 50 GB
      }
    }
  }
 
  nics {
    network_info {
      nic_type = "NORMAL_NIC"
      subnet {
        ext_id = var.subnet_uuid
      }
      vlan_mode = "ACCESS"
    }
  }

  boot_config {
    legacy_boot {
      boot_order = ["DISK", "NETWORK"]
    }
  }
  power_state = "ON"
}