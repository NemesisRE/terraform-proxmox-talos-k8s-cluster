resource "proxmox_virtual_environment_vm" "vms" {
  for_each = var.vms

  node_name = each.value.host_node

  name    = "${var.cluster.name}-${each.key}"
  tags    = ["terraform", "talos", "k8s", each.value.machine_type, var.cluster.name]
  on_boot = true
  started = true

  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"
  bios          = "seabios"

  agent {
    enabled = true
  }

  cpu {
    cores = each.value.cpu
    type  = "host"
  }

  memory {
    dedicated = each.value.ram_dedicated
  }

  network_device {
    bridge  = var.cluster.network_device_bridge
    vlan_id = var.cluster.vlan_id
  }

  # boot disk
  disk {
    datastore_id = each.value.datastore_id
    interface    = "scsi0"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    file_format  = each.value.disk_file_format
    size         = each.value.os_disk_size
    file_id      = proxmox_virtual_environment_download_file.this["${each.value.host_node}_${each.value.gpu != null ? local.image_nvidia_id : local.image_id}"].id
  }

  # data disk
  disk {
    datastore_id = each.value.datastore_id
    interface    = "scsi1"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    file_format  = each.value.disk_file_format
    size         = each.value.data_disk_size
  }

  boot_order = ["scsi0"]

  operating_system {
    type = "l26"
  }

  initialization {
    datastore_id = each.value.datastore_id

    dns {
      domain  = var.cluster.dns_domain
      servers = var.cluster.dns_servers
    }

    ip_config {
      ipv4 {
        address = var.cluster.network_dhcp == true ? "dhcp" : "${each.value.ip}/${var.cluster.cidr}"
        gateway = var.cluster.network_dhcp == true ? null : var.cluster.gateway
      }
    }
  }

  dynamic "hostpci" {
    for_each = (each.value.gpu != null) ? [1] : []
    content {
      # Passthrough GPU
      device  = "hostpci0"
      mapping = each.value.gpu
      pcie    = true
      rombar  = true
      xvga    = false
    }
  }

}

resource "time_sleep" "waiting_if_dhcp" {
  depends_on      = [proxmox_virtual_environment_vm.vms]
  create_duration = (var.cluster.network_dhcp == true) ? "60s" : "0s"
}