# Prerequisites

You need to have installed:

1. `qemu/kvm`
1. `libvirt`
1. `terraform`
1. `ansible`

# How to

## Spin up VMs

Swap default ssh key with your public key in `terraform/templates/cloud_init.yml`.

```
cd terraform
terraform apply
# run once again to set hostnames
terraform apply
sudo virsh reboot kubernetes-master
sudo virsh reboot node-0
sudo virsh reboot node-1
```

You may need to refresh your DNS configuration.

## Provision VMs

Be sure to configure NSS to use libvirt module in order to resolve guest vm hostnames properly. [Sample configuration](https://wiki.archlinux.org/index.php/Libvirt#Access_virtual_machines_using_their_hostnames) from ArchWiki.

```
ansible-playbook site.yml -i inventory.yml
```
