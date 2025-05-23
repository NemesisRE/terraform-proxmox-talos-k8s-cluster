module "talos_k8s_cluster" {
  #  source  = "NemesisRE/talos-k8s-cluster/proxmox"
  #  version = "1.0.0"
  source = "../.."

  cluster = {
    name     = "demo-cluster"
    gateway  = "192.168.10.1"
    cidr     = 24
    endpoint = "192.168.10.210"
  }

  vms = {
    "k8s-cp-0" = {
      host_node      = "pve"
      machine_type   = "controlplane"
      ip             = "192.168.10.210"
      cpu            = 2
      ram_dedicated  = 4096
      os_disk_size   = 10
      data_disk_size = 10
      datastore_id   = "local-lvm"
    }
    "k8s-cp-1" = {
      host_node      = "pve"
      machine_type   = "controlplane"
      ip             = "192.168.10.211"
      cpu            = 2
      ram_dedicated  = 4096
      os_disk_size   = 10
      data_disk_size = 10
      datastore_id   = "local-lvm"
    }
    "k8s-cp-2" = {
      host_node      = "pve"
      machine_type   = "controlplane"
      ip             = "192.168.10.212"
      cpu            = 2
      ram_dedicated  = 4096
      os_disk_size   = 10
      data_disk_size = 10
      datastore_id   = "local-lvm"
    }
  }

  proxmox = {
    endpoint  = "https://pve.domain:8006"
    insecure  = true
    username  = "user"
    password  = "password"
    api_token = "user@pve!terraform=secret"
  }

  gitops = {
    repository   = "https://github.com/NemesisRE/gitops.git"
    token        = "github_pat"
    cluster_name = "my-cluster"
  }

}
