resource "aws_dynamodb_table" "profiles-db" {
  name           = "profiles"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "email"

  attribute {
    name = "email"
    type = "S"
  }

  tags = {
    Name = "profiles-db"
  }
}