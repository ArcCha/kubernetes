resource "libvirt_network" "k8s" {
  name      = "k8s"
  mode      = "nat"
  domain    = "k8s.local"
  addresses = ["10.0.0.0/24"]
  autostart = true
  dhcp {
    enabled = true
  }
  dns {
    enabled    = true
    local_only = true
    forwarders {
      address = "192.168.132.45"
    }
  }
}
