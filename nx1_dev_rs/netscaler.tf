
provider "netscaler" {
  username = "chuck.hilyard"
  password = "${var.netscaler_password}"
  endpoint = "http://lb.wh.reachlocal.com"
}




## variables variables  variables  variables  variables  variables  variables  variables  variables  variables  variables 
## variables variables  variables  variables  variables  variables  variables  variables  variables  variables  variables 
## variables variables  variables  variables  variables  variables  variables  variables  variables  variables  variables 

# why is this not prompting me?
variable "netscaler_password" {}




## resources resources  resources  resources  resources  resources  resources  resources  resources  resources  resources 
## resources resources  resources  resources  resources  resources  resources  resources  resources  resources  resources 
## resources resources  resources  resources  resources  resources  resources  resources  resources  resources  resources 


## csv servers    csv servers    csv servers    csv servers    csv servers    csv servers    csv servers    csv servers
## 
## these are shared resources
resource "netscaler_csvserver" "dvs-cs-wh-nx1-dev-ws-reachlocal-ssl" {
  name = "dvs-cs-wh-nx1-dev-ws-reachlocal-ssl"
  ipv46 = "10.126.255.238"
  port = "443" 
  servicetype = "SSL"
  sslcertkey = "qa.reachlocal.com" 
}

resource "netscaler_cspolicy" "csp-nx1-dev-usa-ws-facebookshim" {
  policyname = "csp-nx1-dev-usa-ws-facebookshim"
  url = "*"
  csvserver = "${netscaler_csvserver.dvs-cs-wh-nx1-dev-ws-reachlocal-ssl.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-nx1-dev-usa-facebookshim-http.name}"
}


# facebookshim
resource "netscaler_lbvserver" "dvs-nx1-dev-usa-facebookshim-http" {
  name = "dvs-nx1-dev-usa-facebookshim-http"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
 }


# cpigateway
resource "netscaler_servicegroup" "dsg-nx1-dev-wh-cpigatewayservice" {
  depends_on = ["netscaler_lbvserver.dvs-nx1-dev-wh-cpigatewayservice"]
  depends_on = ["openstack_compute_instance_v2.cpigateway-usa-web01"]
  lbvserver = "dvs-nx1-dev-wh-cpigatewayservice"
  servicegroupname = "dsg-nx1-dev-wh-cpigatewayservice"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.cpigateway-usa-web01.network.0.fixed_ip_v4}:80"]
 }

resource "netscaler_lbvserver" "dvs-nx1-dev-wh-cpigatewayservice" {
  name = "dvs-nx1-dev-wh-cpigatewayservice"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
 }


