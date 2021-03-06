
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
# ws csv server (shared resources)    
#
# notes
# priority must be unique
#
resource "netscaler_csvserver" "dcsvs-ws-nx1-dev-usa-wh" {
  name = "dcsvs-ws-nx1-dev-usa-wh"
  ipv46 = "10.125.255.238"
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
  priority = "200"
}

resource "netscaler_cspolicy" "csp-campaignservice-nx1-dev-usa-wh" {
  policyname = "csp-campaignservice-nx1-dev-usa-wh"
  rule = "HTTP.REQ.URL.PATH.STARTSWITH(\"/campaign\")"    # <- this is close, the escapes may not work
  csvserver = "${netscaler_csvserver.dcsvs-ws-nx1-dev-usa-wh.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-campaignservice-nx1-dev-usa-wh.name}"
  priority = "201"
}

resource "netscaler_cspolicy" "csp-googleconnector-nx1-dev-usa-wh" {
  policyname = "csp-googleconnector-nx1-dev-usa-wh"
  rule = "HTTP.REQ.URL.PATH.STARTSWITH(\"/googleconnector\")"    # <- this is close, the escapes may not work
  csvserver = "${netscaler_csvserver.dcsvs-ws-nx1-dev-usa-wh.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-googleconnector-nx1-dev-usa-wh.name}"
  priority = "202"
}

resource "netscaler_cspolicy" "csp-bingconnector-nx1-dev-usa-wh" {
  policyname = "csp-bingconnector-nx1-dev-usa-wh"
  rule = "HTTP.REQ.URL.PATH.STARTSWITH(\"/bingconnector\")"    # <- this is close, the escapes may not work
  csvserver = "${netscaler_csvserver.dcsvs-ws-nx1-dev-usa-wh.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-bingconnector-nx1-dev-usa-wh.name}"
  priority = "203"
}

resource "netscaler_cspolicy" "csp-optimization-nx1-dev-usa-wh" {
  policyname = "csp-optimization-nx1-dev-usa-wh"
  rule = "HTTP.REQ.URL.PATH.STARTSWITH(\"/optimization\")"    # <- this is close, the escapes may not work
  csvserver = "${netscaler_csvserver.dcsvs-ws-nx1-dev-usa-wh.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-optimization-nx1-dev-usa-wh.name}"
  priority = "204"
}

resource "netscaler_cspolicy" "csp-advertiserservice-nx1-dev-usa-wh" {
  policyname = "csp-advertiserservice-nx1-dev-usa-wh"
  rule = "HTTP.REQ.URL.PATH.STARTSWITH(\"/advertiser-service\")"    # <- this is close, the escapes may not work
  csvserver = "${netscaler_csvserver.dcsvs-ws-nx1-dev-usa-wh.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-advertiserservice-nx1-dev-usa-wh.name}"
  priority = "205"
}

# **************************************************
# api csv server (shared resources)    
#
# notes
# priority must be unique
#
resource "netscaler_csvserver" "dcsvs-api-nx1-dev-usa-wh" {
  name = "dcsvs-api-nx1-dev-usa-wh"
  ipv46 = "10.125.255.236"
  port = "443" 
  servicetype = "SSL"
  clttimeout = "180"
  sslcertkey = "reachlocal.com" 
}

resource "netscaler_cspolicy" "csp-yelpconnector-nx1-dev-usa-wh" {
  policyname = "csp-yelpconnector-nx1-dev-usa-wh"
  rule = "HTTP.REQ.URL.PATH.STARTSWITH(\"/yelpconnector\")"    # <- this is close, the escapes may not work
  csvserver = "${netscaler_csvserver.dcsvs-api-nx1-dev-usa-wh.name}"
  targetlbvserver = "${netscaler_lbvserver.dvs-yelpconnector-nx1-dev-usa-wh.name}"
  priority = "200"
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
# cpiclient
resource "netscaler_lbvserver" "dvs-cpiclient-nx1-dev-usa-wh" {
  name = "dvs-cpiclient-nx1-dev-usa-wh"
  ipv46 = "10.125.255.239"
  port = "443"
  servicetype = "SSL"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
  sslcertkey = "reachlocal.com" 
 }

resource "netscaler_servicegroup" "dsg-cpiclient-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-cpiclient-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.cpiclient-usa-web01"]
  lbvserver = "dvs-cpiclient-nx1-dev-usa-wh"
  servicegroupname = "dsg-cpiclient-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.cpiclient-usa-web01.network.0.fixed_ip_v4}:80"]
  maxclient = "0"
  maxreq = "0"
  cip = "DISABLED"
  usip = "no" 
  useproxyport = "YES"
  sp = "ON"
  svrtimeout = "360" 
  appflowlog = "DISABLED"
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

# **************************************************
# mediagateway
resource "netscaler_lbvserver" "dvs-mediagateway-nx1-dev-usa-wh" {
  name = "dvs-mediagateway-nx1-dev-usa-wh"
  ipv46 = "10.125.255.237"
  port = "443"
  servicetype = "SSL"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
  appflowlog = "DISABLED"
  sslcertkey = "reachlocal.com" 
 }

resource "netscaler_servicegroup" "dsg-mediagateway-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-mediagateway-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.mediagateway-usa-web01"]
  lbvserver = "dvs-mediagateway-nx1-dev-usa-wh"
  servicegroupname = "dsg-mediagateway-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.mediagateway-usa-web01.network.0.fixed_ip_v4}:8080"]
  lbmonitor = "http-up"
 }

# **************************************************
# campaignservice
resource "netscaler_lbvserver" "dvs-campaignservice-nx1-dev-usa-wh" {
  name = "dvs-campaignservice-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "LEASTCONNECTION"
  persistencetype = "NONE"
  clttimeout = "3600"
 }

resource "netscaler_servicegroup" "dsg-campaignservice-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-campaignservice-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.campaignservice-usa-web01"]
  lbvserver = "dvs-campaignservice-nx1-dev-usa-wh"
  servicegroupname = "dsg-campaignservice-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.campaignservice-usa-web01.network.0.fixed_ip_v4}:8443"]
  lbmonitor = "ws-campaign-http-8443"
 }

# **************************************************
# yelpconnector
resource "netscaler_lbvserver" "dvs-yelpconnector-nx1-dev-usa-wh" {
  name = "dvs-yelpconnector-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "LEASTCONNECTION"
  persistencetype = "NONE"
  clttimeout = "3600"
 }

resource "netscaler_servicegroup" "dsg-yelpconnector-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-yelpconnector-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.yelpconnector-usa-web01"]
  lbvserver = "dvs-yelpconnector-nx1-dev-usa-wh"
  servicegroupname = "dsg-yelpconnector-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.yelpconnector-usa-web01.network.0.fixed_ip_v4}:8080"]
  lbmonitor = ""
 }

# **************************************************
# googleconnector
resource "netscaler_lbvserver" "dvs-googleconnector-nx1-dev-usa-wh" {
  name = "dvs-googleconnector-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
 }

resource "netscaler_servicegroup" "dsg-googleconnector-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-googleconnector-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.googleconnector-usa-web01"]
  lbvserver = "dvs-googleconnector-nx1-dev-usa-wh"
  servicegroupname = "dsg-googleconnector-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.googleconnector-usa-web01.network.0.fixed_ip_v4}:8080"]
  lbmonitor = ""
 }

# **************************************************
# bingconnector
resource "netscaler_lbvserver" "dvs-bingconnector-nx1-dev-usa-wh" {
  name = "dvs-bingconnector-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
  #policyname = "mkg_insert_https_proto_header"
 }

resource "netscaler_servicegroup" "dsg-bingconnector-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-bingconnector-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.bingconnector-usa-web01"]
  lbvserver = "dvs-bingconnector-nx1-dev-usa-wh"
  servicegroupname = "dsg-bingconnector-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.bingconnector-usa-web01.network.0.fixed_ip_v4}:8080"]
 }

# **************************************************
# optimization
resource "netscaler_lbvserver" "dvs-optimization-nx1-dev-usa-wh" {
  name = "dvs-optimization-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
  #policyname = "mkg_insert_https_proto_header"
 }

resource "netscaler_servicegroup" "dsg-optimization-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-optimization-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.optimization-usa-web01"]
  lbvserver = "dvs-optimization-nx1-dev-usa-wh"
  servicegroupname = "dsg-optimization-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.optimization-usa-web01.network.0.fixed_ip_v4}:8080"]
 }

# **************************************************
# advertiserservice
resource "netscaler_lbvserver" "dvs-advertiserservice-nx1-dev-usa-wh" {
  name = "dvs-advertiserservice-nx1-dev-usa-wh"
  servicetype = "HTTP"
  lbmethod = "LEASTCONNECTION"
  persistencetype = "NONE"
  clttimeout = "3600"
 }

resource "netscaler_servicegroup" "dsg-advertiserservice-nx1-dev-usa-wh" {
  depends_on = ["netscaler_lbvserver.dvs-advertiserservice-nx1-dev-usa-wh"]
  depends_on = ["openstack_compute_instance_v2.advertiserservice-usa-web01"]
  lbvserver = "dvs-advertiserservice-nx1-dev-usa-wh"
  servicegroupname = "dsg-advertiserservice-nx1-dev-usa-wh"
  servicetype = "HTTP"
  servicegroupmembers = ["${openstack_compute_instance_v2.advertiserservice-usa-web01.network.0.fixed_ip_v4}:8080"]
 }

