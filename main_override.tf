
# this is the top level tf file.  anything set here overrides all other loaded tf files
# if you want more info on overrides in go here -> https://www.terraform.io/docs/configuration/override.html



## primary user interface starts here
## primary user interface starts here
## primary user interface starts here

terraform {
  required_version = "~> 0.8.5"
}

# a failure here means that powerdns isn't setup for whatever domain
# you're attempting to terraform
variable "domain" {
  default = "nx1.dev.wh.reachlocal.com"
}

# could be any one of usa, aus, can, gbr, eur, jpn
# use what you need but not more
variable "platform" {
  default = ["usa"] 
}

# the purpose here is to load *only* those modules necessary for your specific terraform 
# options are "dev_nx1_rs", "dev_nx1_search", "dev_nx1_display"
module "environment" {
  variable "environment" { 
    default = "dev_nx1_rs"
  }
  source = "./environment/${environment}.tf"
}





## DO NOT EDIT BELOW THESE LINES
## DO NOT EDIT BELOW THESE LINES
## DO NOT EDIT BELOW THESE LINES

module "base" {
  source = "./base"
}

