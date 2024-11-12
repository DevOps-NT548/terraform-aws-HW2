variable "vpc_id" {
  type = string
}

variable "ssh_allowed_ips" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}