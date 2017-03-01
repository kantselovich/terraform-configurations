provider "netscaler" {
  username = "chuck.hilyard"
  password = "${var.netscaler_password}"
  endpoint = "http://lb.wh.reachlocal.com"
}

# cpiclient
#


# cpigateway
#
resource "netscaler_servicegroup" "dsg-nx1-dev-wh-cpigatewayservice" {
  #depends_on = ["netscaler_lbvserver.dvs-nx1-dev-wh-cpigatewayservice"]
  depends_on = ["openstack_compute_instance_v2.mediagateway-usa-web01"]
  lbvserver = "dvs-nx1-dev-wh-cpigatewayservice"
  servicegroupname = "dsg-nx1-dev-wh-cpigatewayservice"
  servicetype = "HTTP"
  #
  # in order for servicegroupmembers to work with names, rather than IP addresses, we'll have to include some sort of kludge.    
  # we could write a small script to add the FQDN entries below to the target LB via the API.  we can use the same provider
  # netscaler username/password and endpoint (above). 
  #
  # via the netscaler CLI the command looks like this;
  #   add server cpigateway-aus-web01.syd.reachlocal.com cpigateway-aus-web01.syd.reachlocal.com
  #   rm server cpigateway-aus-web01.syd.reachlocal.com  
  #
  servicegroupmembers = ["${openstack_compute_instance_v2.mediagateway-usa-web01.network.0.fixed_ip_v4}:80", "${openstack_compute_instance_v2.mediagateway-usa-web02.network.0.fixed_ip_v4}:80" ]
 }

resource "netscaler_lbvserver" "dvs-nx1-dev-wh-cpigatewayservice" {
  name = "dvs-nx1-dev-wh-cpigatewayservice"
  servicetype = "HTTP"
  lbmethod = "ROUNDROBIN"
  persistencetype = "NONE"
  clttimeout = "3600"
 }

#resource "netscaler_csvserver" "" {
  #name = "chilyard-test-csvserver"
  #ipv46 = "10.126.255.238"
  #port = "443" 
  #servicetype = "SSL"
  #sslcertkey = "qa.reachlocal.com" 
#}

#resource "netscaler_cspolicy" "chilyard-test-cspolicy" {
  #policyname = "chilyard-test-cspolicy" 
  #url = "*"
  #csvserver = "${netscaler_csvserver.chilyard-test-csvserver.name}"
  #targetlbvserver = "${netscaler_lbvserver.chilyard-test-lbvserver.name}"
#}


# mediagateway
#

