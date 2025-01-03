variable "bucket_name" {
  type        = string
  description = "S3 bucket name for storing the terraform state file"
}

variable "region" {
  type        = string
  description = "AWS region"
}


variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for storing the terraform state lock"
}

# End of variable.tf   

