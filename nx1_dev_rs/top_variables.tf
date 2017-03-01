# 
#


# a failure here means that powerdns isn't setup for whatever domain
# you're attempting to terraform
variable "domain" {
  default = "dev.wh.reachlocal.com"
}

# could be any one of usa, aus, can, gbr, eur, jpn
# use what you need but not more
variable "platform" {
  default = ["usa"] 
}


