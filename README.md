# Prerequisites

You need to have installed:

1. `qemu/kvm`
1. `libvirt`
1. `terraform`
1. `ansible`

# How to

## Spin up VMs

Public ssh key is expected to be provided as a root module variable.
You can set it using environment variable `TF_VAR_ssh_key_pub`.

```
cd terraform
terraform apply
# run once again to set hostnames
terraform apply
sudo virsh reboot master
sudo virsh reboot node-0
sudo virsh reboot node-1
```

You may need to refresh your DNS configuration.

## Provision VMs

Be sure to configure NSS to use libvirt module in order to resolve guest vm hostnames properly. [Sample configuration](https://wiki.archlinux.org/index.php/Libvirt#Access_virtual_machines_using_their_hostnames) from ArchWiki.

```
ansible-playbook site.yml -i inventory.yml
```

## Initialize cluster

### Networking assumptions

- `10.0.0.0/??` - node network
- `10.1.0.0/16` - pod network
- `10.2.0.0/16` - traditional network
- `10.3.0.0/16` - small pools network
- `10.4.0.0/16` - service network


Master initialization

```
sudo kubeadm init --pod-network-cidr=10.1.0.0/16 --service-cidr=10.4.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f calico.yaml
```

Node join (this command will be printed by master initialization command)

```
kubeadm join MASTER_IP:6443 --token REDACTED \
    --discovery-token-ca-cert-hash sha256: REDACTED
```

# Operations

## Service advertisement

As per [TODO INSERT LINK]() we can employ ECMP routing to advertise services outside of a cluster. We need to provide routes to each of our nodes, traffic sent to a node concerning specific service will be internally rerouted to correct pod.

E.g. on host

```
sudo ip route add 10.3.0.0/16 proto static scope global \
nexthop via NODE_0_IP weight 1 \
nexthop via NODE_1_IP weight 1
```
