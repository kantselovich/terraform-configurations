
# this is the top level tf file.  anything set here overrides all other loaded tf files
# if you want to figure out overrides in tf go here -> https://www.terraform.io/docs/configuration/override.html
#
# primary user interface starts here

terraform {
  required_version = "~> 0.8.5"
}

variable "domain" {
  # a failure here means that powerdns isn't setup for whatever domain
  # you're attempting to terraform
  default = "nx1.dev.wh.reachlocal.com"
}

variable "platform" {
  # could be any one of usa, aus, can, gbr, eur, jpn
  # use what you need but not more
  default = ["usa"] 
}

variable "environment" {
  # the purpose here is to load *only* those modules necessary for your specific terraform 
  # options are "dev_nx1_rs", "dev_nx1_search", "dev_nx1_display"
  default = "dev_nx1_rs"
}






## DO NOT EDIT BELOW THESE LINES
## DO NOT EDIT BELOW THESE LINES
## DO NOT EDIT BELOW THESE LINES

module "common" {
  source = "./common"
}

module "dev_nx1_rs" {
  source = "./dev_nx1_rs"
}

module "dev_nx1_search" {
  source = "./dev_nx1_search"
}
