resource "libvirt_network" "k8s" {
  name      = "k8s"
  mode      = "nat"
  domain    = "k8s.local"
  addresses = ["10.0.0.0/24"]
  autostart = true
  dhcp {
    enabled = true
  }
}
