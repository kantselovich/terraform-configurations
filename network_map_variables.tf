
# the terraform-provider-netscaler plugin doesn't handle creating LB entries w/ fqdn.  so here we are, creating a master
# list of 

variable "dedicated_ips" {
    default = {
    cpigatewayservice.node01 = "10.105.4.155"
    cpigatewayservice.node02 = "10.105.4.156"
    }
}
