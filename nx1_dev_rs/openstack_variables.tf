# this is specifically for mediagateway node builds
variable "apps_mediagateway" {
  type = "map"
  default = {
    puppetClasses = "apps_mediagateway" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=mediagateway|sub=app"
  }
}

