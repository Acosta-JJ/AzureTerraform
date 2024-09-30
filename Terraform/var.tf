variable "name" {
  type = string
  default = "origenAI-JoseAcosta"
}

variable "resource_group_name" {
  type = string
  default = "origenAI"
}

variable "location" {
  type = string
  default = "northeurope"
}

variable "node_count" {
  type = string
  default = 2
}

variable "k8s_version" {
    type = string
    default = "1.28.5"
}