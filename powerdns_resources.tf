
provider "powerdns" {
  api_key = "${var.pdns_api_key}"
  server_url = "${var.pdns_server_url}"
}

resource "powerdns_record" "chilyardtest" {
  zone = "nx1.dev.wh.reachlocal.com"
  name = "chilyardtest."
  type = "A"
  ttl = 300
  records = ["192.168.0.12"]
}
