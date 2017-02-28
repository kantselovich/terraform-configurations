
# this is the top level tf file.  
#
# switch your environments around at this level


terraform {
  required_version = "~> 0.8.5"
}

module "base" {
  source = "./base"
}


# you should really only edit below these lines
# you should really only edit below these lines
# you should really only edit below these lines

module "environment" {
  source = "./nx1_dev_rs"
}
