
provider "powerdns" {
  api_key = "${var.pdns_api_key}"
  server_url = "${var.pdns_server_url}"
}




# variables variables variables variables variables variables variables variables variables variables variables variables
# variables variables variables variables variables variables variables variables variables variables variables variables
# variables variables variables variables variables variables variables variables variables variables variables variables

variable "pdns_api_key" {
  default = "otto"
}

variable "pdns_server_url" {
  default = "http://rlpc.wh.reachlocal.com:8080"
}




# resources resources resources resources resources resources resources resources resources resources resources resources
# resources resources resources resources resources resources resources resources resources resources resources resources
# resources resources resources resources resources resources resources resources resources resources resources resources

resource "powerdns_record" "chilyardtest" {
  zone = "nx1.dev.wh.reachlocal.com"
  name = "chilyardtest."
  type = "A"
  ttl = 300
  records = ["192.168.0.12"]
}
