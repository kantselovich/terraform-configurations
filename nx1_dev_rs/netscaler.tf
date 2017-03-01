
#### provider 

provider "netscaler" {
  username = "chuck.hilyard"
  password = "${var.netscaler_password}"
  endpoint = "http://lb.wh.reachlocal.com"
}




#### local variables 



#### resources 

# naming convention
# $anything.$env.$plat.$dc.reachlocal.com


# **************************************************
# csv servers (shared resources)    
resource "netscaler_csvserver" "dcsvs-ws-nx1-dev-usa-wh" {
  name = "dcsvs-ws-nx1-dev-usa-wh"
  ipv46 = "10.126.255.238"
  port = "443" 
  servicetype = "SSL"
  clttimeout = "180"
  sslcertkey = "reachlocal.com" 
}

resource "netscaler_cspolicy" "csp-facebookshim-nx1-dev-usa-wh" {
  policyname = "csp-facebookshim-nx1-dev-usa-wh"
  rule = "HTTP.REQ.URL.PATH.STARTSWITH(\"/facebookshim\")"    # <- this is close, the escapes may not work
  csvserver = "${netscaler_csvserver.dcsvs-ws-nx1-dev-usa-wh.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-facebookshim-nx1-dev-usa-wh.name}"
  priority = 200
}



# **************************************************
# facebookshim
resource "netscaler_lbvserver" "dvs-facebookshim-nx1-dev-usa-wh" {
  name = "dvs-facebookshim-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
 }

resource "netscaler_servicegroup" "dsg-facebookshim-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-facebookshim-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.facebookshim-usa-web01"]
  lbvserver = "dvs-facebookshim-nx1-dev-usa-wh"
  servicegroupname = "dsg-facebookshim-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.facebookshim-usa-web01.network.0.fixed_ip_v4}:8080"]
 }


# **************************************************
# cpigateway
resource "netscaler_lbvserver" "dvs-cpigateway-nx1-dev-usa-wh" {
  name = "dvs-cpigateway-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
 }

resource "netscaler_servicegroup" "dsg-cpigateway-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-cpigateway-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.cpigateway-usa-web01"]
  lbvserver = "dvs-cpigateway-nx1-dev-usa-wh"
  servicegroupname = "dsg-cpigateway-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.cpigateway-usa-web01.network.0.fixed_ip_v4}:80"]
 }


