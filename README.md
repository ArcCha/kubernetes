# Prerequisites

You need to have installed:

1. `qemu/kvm`
1. `libvirt`
1. `terraform`
1. `ansible`

# How to

## Spin up VMs

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

```
ansible-playbook site.yml -i inventory.yml
```
