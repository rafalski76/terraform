variable "enabled" {
  type    = bool
  default = true
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "name" {
  type = string
}

variable "ami" {
  type = string
}

variable "key_pair_name" {
  type = string
}