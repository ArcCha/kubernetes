provider "libvirt" {
  uri = "qemu:///system"
}

/* resource "libvirt_domain" "test-domain" { */
/*   name   = "test-vm-centos" */
/*   memory = "2048" */
/*   vcpu   = 1 */
/*  */
/*   network_interface { */
/*     network_name = "default" */
/*   } */
/*  */
/*   console { */
/*     type = "pty" */
/*     target_type = "serial" */
/*     target_port = "0" */
/*   } */
/*  */
/*   disk { */
/*     volume_id = libvirt_volume.centos-image.id */
/*   } */
/*  */
/*   graphics { */
/*     type = "spice" */
/*     listen_type = "adress" */
/*     autoport = true */
/*   } */
/* } */
