output "Use this link to access Kubernetes dashboard" {
  value = "http://localhost:8001/ui/"
}
output "Then to access the dashboard locally run" {
  value = "kubectl --kubeconfig ./admin.conf proxy"
}
output "To connect to the API Server and viewing the dashboard copy the configuration locally" {
  value = "scp root@${scaleway_server.kubernetes_master.public_ip}:/etc/kubernetes/admin.conf ."
}
output "slave-ip" {
  value = "${join(",", scaleway_server.kubernetes_slave.*.public_ip)}"
}
output "master-ip" {
  value = "${join(",", scaleway_server.kubernetes_master.public_ip)}"
}

