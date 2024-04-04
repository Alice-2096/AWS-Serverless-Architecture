module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name      = var.table_name
  hash_key  = var.hash_key
  range_key = var.range_key

  attributes = [{
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

  # billing_mode   = var.billing_mode
  # read_capacity  = var.read_capacity
  # write_capacity = var.write_capacity

  local_secondary_indexes  = var.lsi
  global_secondary_indexes = var.gsi

  # server_side_encryption_enabled = true 
  # server_side_encryption_kms_key_arn = var.kms_key_arn 

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

