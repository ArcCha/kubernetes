resource "libvirt_domain" "master" {
  name   = "master"
  memory = "4096"
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_id     = libvirt_network.k8s.id
    hostname       = "master"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.master.id
  }
}

resource "libvirt_domain" "node" {
  count  = 2
  name   = "node-${count.index}"
  memory = "2048"
  vcpu   = 1

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_id     = libvirt_network.k8s.id
    hostname       = "node-${count.index}"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.node["${count.index}"].id
  }
}

output "master_ip" {
  value = libvirt_domain.master.network_interface.0.addresses
}

output "node_ips" {
  value = libvirt_domain.node.*.network_interface.0.addresses
}
