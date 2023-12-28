terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "Mannys-Org"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

module "home_tvseries_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.tvseries.public_path
  content_version = var.tvseries.content_version
}

resource "terratowns_home" "home" {
  name        = "The best top 3 TV series of 2023"
  description = <<DESCRIPTION
There are a lot of TV series that were released in 2023. Some of the
best TV series are low though. I'll be liting the top 3 on the list.
All of these are personal opinions, you can specify yours as well :)
DESCRIPTION
  domain_name = module.home_tvseries_hosting.domain_name
  town            = "video-valley"
  content_version = var.tvseries.content_version
}

module "home_food_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.food.public_path
  content_version = var.food.content_version
}

resource "terratowns_home" "home_food" {
  name            = "Making my best Ethiopian Dish - Firfir"
  description     = <<DESCRIPTION
The staple food of Ethiopia, "Injera", can be made into a delicious food by
adding up some spices combining it with the Injera itself. It's the best dish
out there for me, So we'll get on with making one :). ሰላም ሃበሾች ፡)
DESCRIPTION
  domain_name     = module.home_food_hosting.domain_name
  town            = "cooker-cove"
  content_version = var.food.content_version
}
