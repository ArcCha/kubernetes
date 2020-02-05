resource "libvirt_pool" "kubernetes" {
  name = "kubernetes"
  type = "dir"
  path = "/home/ap2/Work/Kubernetes/images"
}

resource "libvirt_volume" "centos7_cloud" {
  name   = "centos7_cloud.qcow2"
  pool   = libvirt_pool.kubernetes.name
  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  pool      = libvirt_pool.kubernetes.name
  user_data = file("${path.module}/templates/cloud_init.tmpl")
}

resource "libvirt_volume" "master" {
  name           = "master.qcow2"
  pool           = "kubernetes"
  base_volume_id = libvirt_volume.centos7_cloud.id
}

resource "libvirt_volume" "node" {
  count          = 2
  name           = "node-${count.index}.qcow2"
  pool           = "kubernetes"
  base_volume_id = libvirt_volume.centos7_cloud.id
}

resource "libvirt_volume" "vbs" {
  count          = 1
  name           = "vbs-${count.index}.qcow2"
  pool           = "kubernetes"
  base_volume_id = libvirt_volume.centos7_cloud.id
}

resource "libvirt_volume" "registry" {
  name           = "registry.qcow2"
  pool           = "kubernetes"
  base_volume_id = libvirt_volume.centos7_cloud.id
}
