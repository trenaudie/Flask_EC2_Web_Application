terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-3"
}




# resource "aws_s3_bucket" "bucket1" {
#   bucket = var.bucket_name
#   tags = {
#     Name        = "My bucket Name"
#     Environment = "Dev"
#   }
#   force_destroy = true
# }



# resource "aws_s3_bucket" "bucket2" {
#   bucket = "athenaoutputtanguy123456789"
#   tags = {
#     Name        = "My bucket Name"
#     Environment = "Dev"
#   }
#   force_destroy = true
# }

# resource "aws_redshift_cluster" "cluster1" {
#   cluster_identifier = "tf-redshift-cluster-1"
#   database_name      = "tanguydb1"
#   master_username    = "tanguyrenaudie"
#   master_password    = "LUcas50!!"
#   node_type          = "dc2.large"
#   cluster_type       = "single-node"
#   skip_final_snapshot = true
#   iam_roles = [var.redshift_iam_role]
#   }



# resource "aws_glue_crawler" "example" {
#   database_name = "peopleTweets"
#   name          = "crawler_df"
#   role          = "arn:aws:iam::799629864843:role/service-role/AWSGlueServiceRole-Enigma"

#   s3_target {
#     path = "s3://${aws_s3_bucket.bucket1.bucket}"
#   }
# }


#ami-03b755af568109dc3
resource "aws_instance" "web" {
  ami           = "ami-03b755af568109dc3"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0a81a8facaa9279fe"]
  key_name = aws_key_pair.flask_key_1_resource.key_name

  tags = {
    Name = "FlaskInstance"
  }
}

resource "aws_key_pair" "flask_key_1_resource" {
  key_name   = "flask_key_1_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLkBJpfNVqiv5IRq8+alSqWD+bFj0ML0TPJSGk+aDeg14ttSQlzLiPQIQBhdRdbC3ja12WJih5RmuHlauyJX+FUcTOBm7R/gx0JMwFmK/e+uM3WF1WZzr4w3OrBsbPQ9W/5KpCPv5Y4V5anvST8M91I3sGiUftlxllCw6Z/TMXxV7YQtKHQKCmDd5YfzNBHLLrgvFT5d3jyokP0ocvN7vLkaZrOai5P0cCBdrzGYMRLpvHB/aZboLmJhBRUvS6p8hT0UAOEe1epdgguLrFjpoizqtDCtD/ntaPPJeoIMRnOLqyT8dXDmWTUItSib0P+K497S7whD+nXtooWELXC8lJZl7SqtOdc5x7CagBRX/nq2E2rQr2o29+Th+BwU9o+DXkWKuTDaJBnf/Z5uaxoI/+eZ+i1r7MKK6+NRHug7P/A422z4YR6P7lnSxSoYYV0t+4Iu2FTrrbfCdxL5b5yilqTN+MUDDKVqIr7uYATyoQwnTd1ZLA4fgMUm7ZJdx+n18= tanguyrenaudie@Tanguys-MBP"
}
