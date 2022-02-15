variable "instance_name" {
  type        = string
  description = "Prefix nazwy instancji"
  default     = "Nazwa"
}

variable "key_name" {
  type    = string
  default = "infoshare-devops"
}

variable "instance_names" {
  type = list(string)
}
