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
  user_data = "${file("modules/base_init.txt")}"

  network {
    name = "DEV_APP"
  }

  network {
    name = "DEV_STOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "cpigateway-usa-web01" {
  name = "cpigateway-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_cpi_gateway_service}"
  user_data = "${file("modules/base_init.txt")}"

  network {
    name = "DEV_APP"
  }

  network {
    name = "DEV_STOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "cpiclient-usa-web01" {
  name = "cpiclient-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_cpi_client}"
  user_data = "${file("modules/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "yelpconnector-usa-web01" {
  name = "yelpconnector-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_yelp_connector}"
  user_data = "${file("modules/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}
