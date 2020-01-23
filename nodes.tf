resource "libvirt_domain" "master" {
  name    = "kubernetes-master"
  memory  = "1024"
  vcpu    = 1

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_id      = libvirt_network.k8s.id 
    hostname        = "master"
    wait_for_lease  = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  disk {
    volume_id   = libvirt_volume.master.id
  }
}
