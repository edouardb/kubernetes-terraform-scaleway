variable "organization_key" {
  description = "Scaleway access_key"
  default = "00000000-0000-0000-0000-000000000000"
}

variable "secret_key" {
  description = "Scaleway secret_key"
  default = "00000000-0000-0000-0000-000000000000"
}

variable "region" {
  description = "Scaleway region: Paris (PAR1) or Amsterdam (AMS1)"
  default = "ams1"
}

variable "user" {
  description = "Username to connect the server"
  default = "root"
}

variable "dynamic_ip" {
  description = "Enable or disable server dynamic public ip"
  default = "true"
}

variable "bootscript_id" {
  description = "Scaleway bootscript ID"
  default = "00000000-0000-0000-0000-000000000000"
}

variable "base_image_id" {
  description = "Scaleway image ID"
  default = "00000000-0000-0000-0000-000000000000"
}

variable "scaleway_slave_type" {
  description = "Instance type of Slave"
  default = "VC1S"
}

variable "scaleway_master_type" {
  description = "Instance type of Master"
  default = "VC1S"
}

variable "kubernetes_cluster_name" {
  description = "Name of your cluster. Alpha-numeric and hyphens only, please."
  default = "scaleway-kubernetes"
}

variable "kubernetes_slave_count" {
  description = "Number of agents to deploy"
  default = "4"
}

variable "kubernetes_ssh_public_key_path" {
  description = "Path to your public SSH key path"
  default = "./scw.pub"
}

variable "kubernetes_ssh_key_path" {
  description = "Path to your private SSH key for the project"
  default = "./scw"
}
