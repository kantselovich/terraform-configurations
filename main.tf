

terraform {
  required_version = "~> 0.8.5"
}

variable "domain" {
  # this consequently is your environment (aka dev, qa, stg, prod)
  # a failure here means that powerdns isn't setup for whatever domain
  # you're attempting to terraform
  default = "nx1.dev.wh.reachlocal.com"
}

variable "platform" {
  # could be any one of usa, aus, can, gbr, eur, jpn
  default = ["usa"] 
}

