variable "oci_core_vcn_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "oci_core_vcn_dns_label" {
  type    = string
  default = "defaultvcn"
}

variable "oci_core_subnet_cidr10" {
  type    = string
  default = "10.0.0.0/24"
}

variable "oci_core_subnet_dns_label10" {
  type    = string
  default = "defaultsubnet10"
}

variable "https_lb_port" {
  type    = number
  default = 443
}

variable "expose_kubeapi" {
  type    = bool
  default = true
}

variable "my_public_ip_cidr" {
  type        = string
  description = "My public ip CIDR"
}

variable "http_lb_port" {
  type    = number
  default = 80
}

variable "kube_api_port" {
  type    = number
  default = 6443
}