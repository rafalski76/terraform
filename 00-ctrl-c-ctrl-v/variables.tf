variable "instance_names" {
  type = list(string)
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. `app` or `jenkins`"
}

variable "vpc_cidr" {
  type    = string
  default = "10.11.0.0/16"
}

variable "vpc_az_count" {
  type        = number
  description = "How many AZs should the vpc span into"
  default     = 2
}
variable "vpc_enable_s3_endpoint" {
  type    = bool
  default = false
}
variable "vpc_public_networks_new_bits" {
  type        = number
  description = "For explanation look up new_bits here: https://registry.terraform.io/modules/hashicorp/subnets/cidr/latest"
  default     = 6
}
variable "vpc_private_networks_new_bits" {
  type        = number
  description = "For explanation look up new_bits here: https://registry.terraform.io/modules/hashicorp/subnets/cidr/latest"
  default     = 4
}
variable "vpc_database_networks_new_bits" {
  type        = number
  description = "For explanation look up new_bits here: https://registry.terraform.io/modules/hashicorp/subnets/cidr/latest"
  default     = 6
}