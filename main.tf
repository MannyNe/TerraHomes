terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

/* module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  assets_path = var.assets_path
  content_version = var.content_version
} */

resource "terratowns_home" "home" {
  name = "The best top 3 TV series of 2023"
  description = <<DESCRIPTION
There are a lot of TV series that were released in 2023. Some of the
best TV series are low though. I'll be liting the top 3 on the list.
All of these are personal opinions, you can specify yours as well :)
DESCRIPTION
  domain_name = "3fdq3gz.cloudfront.net"
  town = "video-valley"
  content_version = 1
}