
variable "netscaler_password" {}
#variable "platform" {}
#variable "environment" {}

variable "pdns_api_key" {
  default = "otto"
}

variable "pdns_server_url" {
  default = "http://rlpc.wh.reachlocal.com:8080"
}

# this is specifically for mediagateway node builds
variable "apps_mediagateway" {
  type = "map"
  default = {
    puppetClasses = "apps_mediagateway" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=mediagateway|sub=app"
  }
}

# this is specifically for cpigateway node builds
variable "apps_cpi_gateway_service" {
  type = "map"
  default = {
    puppetClasses = "apps_cpi_gateway_service" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=cpigatewayservice|sub=app"
  }
}

# this is specifically for cpiclient node builds
variable "apps_cpi_client" {
  type = "map"
  default = {
    puppetClasses = "apps_cpi_client" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=cpiclient|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_yelp_connector" {
  type = "map"
  default = {
    puppetClasses = "apps_yelp_connector" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=yelpconnector|sub=web"
  }
}
