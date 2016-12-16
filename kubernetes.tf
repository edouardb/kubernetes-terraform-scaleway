provider "scaleway" {
  organization = "${var.organization_key}"
  access_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "scaleway_server" "kubernetes_master" {
  name = "${format("${var.kubernetes_cluster_name}-master-%02d", count.index)}"
  image = "${var.base_image_id}"
  dynamic_ip_required = "${var.dynamic_ip}"
  type = "${var.scaleway_master_type}"
  connection {
    user = "${var.user}"
    private_key = "${file(var.kubernetes_ssh_key_path)}"
  }

  provisioner "local-exec" {
    command = "rm -rf ./scw-install.sh ./scw-install-master.sh"
  }
  provisioner "local-exec" {
    command = "echo ${format("MASTER_%02d", count.index)}=\"${self.public_ip}\" >> ips.txt"
  }

  provisioner "local-exec" {
    command = "echo CLUSTER_NAME=\"${var.kubernetes_cluster_name}\" >> ips.txt"
  }
  provisioner "local-exec" {
    command = "./make-files.sh"
  }

  provisioner "local-exec" {
    command = "while [ ! -f ./scw-install.sh ]; do sleep 1; done"
  }

  provisioner "file" {
    source = "./scw-install.sh"
    destination = "/tmp/scw-install.sh"
  }

  provisioner "remote-exec" {
    inline = "bash /tmp/scw-install.sh master"
  }

}

resource "scaleway_server" "kubernetes_slave" {
  name = "${format("${var.kubernetes_cluster_name}-slave-%02d", count.index)}"
  depends_on = ["scaleway_server.kubernetes_master"]
  image = "${var.base_image_id}"
  dynamic_ip_required = "${var.dynamic_ip}"
  type = "${var.scaleway_slave_type}"
  count = "${var.kubernetes_slave_count}"
  connection {
    user = "${var.user}"
    private_key = "${file(var.kubernetes_ssh_key_path)}"
  }
  provisioner "local-exec" {
    command = "while [ ! -f ./scw-install.sh ]; do sleep 1; done"
  }
  provisioner "file" {
    source = "scw-install.sh"
    destination = "/tmp/scw-install.sh"
  }
  provisioner "remote-exec" {
    inline = "bash /tmp/scw-install.sh slave"
  }
}

