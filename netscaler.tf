provider "netscaler" {
  username = "chuck.hilyard"
  password = "${var.netscaler_password}"
  endpoint = "http://lb.wh.reachlocal.com"
}

 resource "netscaler_servicegroup" "chilyard-test-sg" {
   depends_on = ["netscaler_lbvserver.chilyard-test-lbvserver"]
   lbvserver = "chilyard-test-lbvserver"
   servicegroupname = "chilyard-test-group"
   servicetype = "HTTP"
   servicegroupmembers = [ "rundeck-usa-app01.dev.wh.reachlocal.com:80" ]
 }


 resource "netscaler_lbvserver" "chilyard-test-lbvserver" {
   name = "chilyard-test-lbvserver"
   ipv46 = "10.126.255.238"
   port = "80"
   servicetype = "HTTP"
   lbmethod = "ROUNDROBIN"
   persistencetype = "COOKIEINSERT"
   clttimeout = "3600"
 }

