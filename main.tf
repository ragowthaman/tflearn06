provider "aws" {

  region = var.aws_region
}

provider "random" {
}

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfc_example_table" {
  name = "${var.db_table_name}-${random_pet.table_name.id}"

  read_capacity  = var.db_read_capacity
  write_capacity = var.db_write_capacity
  hash_key       = "UUID"
  range_key      = "UserName"

  attribute {
    name = "UUID"
    type = "S"
  }

  attribute {
    name = "UserName"
    type = "S"
  }
}


resource "aws_vpc" "tf_vpc01" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name: "tf-vpc01"
    "project": "tf-learn03"
  } 
}