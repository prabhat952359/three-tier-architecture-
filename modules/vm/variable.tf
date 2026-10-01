variable "virtual-machine" {}

variable "subnet_ids" {
  type = map(string)
}

variable "publicip_ids" {
  type = map(string)
}