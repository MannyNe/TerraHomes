terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_acess_token
}

module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  assets_path         = var.assets_path
  content_version     = var.content_version
}

resource "terratowns_home" "home" {
  name        = "The best top 3 TV series of 2023"
  description = <<DESCRIPTION
There are a lot of TV series that were released in 2023. Some of the
best TV series are low though. I'll be liting the top 3 on the list.
All of these are personal opinions, you can specify yours as well :)
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  //domain_name     = "3fdq3gzhy.cloudfront.net"
  town            = "missingo"
  content_version = 1
}
