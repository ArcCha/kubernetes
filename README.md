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
# TODO virsh restart domains
# TODO terraform apply once more to set hostnames
```

## Provision VMs

```
ansible-playbook site.yml -i inventory.yml
```
