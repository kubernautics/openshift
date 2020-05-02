# -[Disk]-------------------------------------------------------------
resource "libvirt_volume" "coreos-disk" {
  name             = "${format(var.hostname_format, count.index + 1)}.qcow2"
  count            = var.hosts
  pool             = "default"
  format           = "qcow2"
  #base_volume_name = "${var.coreos_production_qemu}"
}

# -[Instance]----------------------------------------------------------
resource "libvirt_domain" "coreos-machine" {
  count  = var.hosts
  name   = format(var.hostname_format, count.index + 1)
  vcpu   = "1"
  memory = "2048"

  ## Use qemu-agent in conjunction with the container
  #qemu_agent = true
  #coreos_ignition = element(libvirt_ignition.ignition.*.id, count.index)

  disk {
    volume_id = element(libvirt_volume.coreos-disk.*.id, count.index)
  }

  graphics {
    ## Bug in linux up to 4.14-rc2
    ## https://bugzilla.redhat.com/show_bug.cgi?id=1432684
    ## No Spice/VNC available if more than one machine is generated at a time
    ## Comment the address line, uncomment the none line and the console block below
    #listen_type = "none"
    listen_type = "address"
  }

  ## Makes the tty0 available via `virsh console`
  console {
    type = "pty"
    target_port = "0"
  }

  # Wait for network lease requires qemu-agent container if network is not native to libvirt
  network_interface {
  # wait_for_lease = true
    network_name = "external"
  }
  ## mounts filesystem local to the kvm host. used to patch in the
  ## qemu-guest-agent as docker container
  #filesystem {
  #  source = "/srv/images/"
  #  target = "qemu_docker_images"
  #  readonly = true
  #}
}
