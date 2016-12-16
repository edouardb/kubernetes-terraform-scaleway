# kubernetes-terraform

[Terraform](https://terraform.io) formula for creating a [Kubernetes](http://kubernetes.io) cluster running on [Scaleway](https://scaleway.com)

The default configuration includes Kubernetes
[add-ons](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons):
DNS, Dashboard and UI.

## Getting started:
Clone or download repo.

Copy `sample.terraform.tfvars` to `terraform.tfvars` and insert your variables.


```bash
$ brew update && brew install kubect terraform

$ terraform plan

$ terraform apply

$ scp root@<master_ip>:/etc/kubernetes/admin.conf .

$ kubectl --kubeconfig ./admin.conf proxy
```
Access the dashboard and api via the following address:

- API: `http://localhost:8001/api/v1`
- Dashboard: `http://localhost:8001/ui`
