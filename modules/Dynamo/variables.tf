variable "environment" {
  default = "dev"
}
variable "table_attributes" {
  type = list(object({}))

  default = [{
    name = "id"
    type = "N"
    },
    {
      name = "email"
      type = "S"
    },
    {
      name = "password"
      type = "S"
  }]
}
variable "table_name" {
  default = "my-table"
}
variable "hash_key" {
  default = "id"
}

variable "lsi" {
  default = [{
    name               = "email-index"
    hash_key           = "email"
    range_key          = "password"
    projection_type    = "INCLUDE"
    non_key_attributes = ["email", "password"]
  }]
}
variable "gsi" {
  default = [{
    name            = "email-index"
    hash_key        = "email"
    range_key       = "password"
    projection_type = "ALL"
  }]
}

# variable "kms_key_arn" {}
variable "billing_mode" {
  default = "PROVISIONED"
}
variable "read_capacity" {
  default = 1
}
variable "write_capacity" {
  default = 1
}

