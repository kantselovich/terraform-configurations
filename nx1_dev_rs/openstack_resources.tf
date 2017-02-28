# Configure the OpenStack Provider
provider "openstack" {
  user_name  = "chuck.hilyard"
  tenant_name = "development"
  password  = "XCqc07ulkLPc2Xzf"
  auth_url  = "http://rlpc.wh.reachlocal.com:5000/v2.0/"
}

variable image_name {
  default = "Ubuntu 12.04.5 LTS"
}

# Create servers
resource "openstack_compute_instance_v2" "mediagateway-usa-web01" {
  name = "mediagateway-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_mediagateway}"
  user_data = "${file("base/base_init.txt")}"


  network {
    name = "DEV_APP"
  }

  network {
    name = "DEV_STOR"
  }

}

