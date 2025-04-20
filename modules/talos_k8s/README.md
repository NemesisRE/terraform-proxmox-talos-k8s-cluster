<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [opentofu](#requirement\_opentofu) | >= 1.8 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >=0.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | >=0.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [talos_cluster_kubeconfig.this](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/resources/cluster_kubeconfig) | resource |
| [talos_machine_bootstrap.this](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.controlplane](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker_gpu](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.this](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/resources/machine_secrets) | resource |
| [talos_client_configuration.this](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/datasources/client_configuration) | data source |
| [talos_cluster_health.this](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/datasources/cluster_health) | data source |
| [talos_machine_configuration.controlplane](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/datasources/machine_configuration) | data source |
| [talos_machine_configuration.worker](https://search.opentofu.org/provider/siderolabs/talos/latest/docs/datasources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Cluster configuration | <pre>object({<br/>    name         = string<br/>    endpoint     = string<br/>    network_dhcp = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | Configuration for worker nodes | <pre>map(object({<br/>    machine_type = string<br/>    ip           = string<br/>    install_disk = optional(string, "/dev/sda")<br/>    gpu          = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubernetes configuration file |
| <a name="output_talos_config"></a> [talos\_config](#output\_talos\_config) | Talos configuration file |
<!-- END_TF_DOCS -->
