
## provider provider provider provider provider provider provider provider provider provider provider provider provider 

# Configure the OpenStack Provider
provider "openstack" {
  user_name  = "chuck.hilyard"
  tenant_name = "development"
  password  = "${var.openstack_password}"
  auth_url  = "http://rlpc.wh.reachlocal.com:5000/v2.0/"
}





## variables variables variables variables variables variables variables variables variables variables variables variables

variable image_name {
  default = "Ubuntu 12.04.5 LTS"
}

# this is specifically for mediagateway node builds
variable "apps_mediagateway" {
  type = "map"
  default = {
    puppetClasses = "apps_mediagateway" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=mediagateway|sub=app"
  }
}

# this is specifically for cpigateway node builds
variable "apps_cpi_gateway_service" {
  type = "map"
  default = {
    puppetClasses = "apps_cpi_gateway_service" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=cpigatewayservice|sub=app"
  }
}

# this is specifically for cpiclient node builds
variable "apps_cpi_client" {
  type = "map"
  default = {
    puppetClasses = "apps_cpi_client" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=cpiclient|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_yelp_connector" {
  type = "map"
  default = {
    puppetClasses = "apps_yelp_connector" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=yelpconnector|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_google_connector" {
  type = "map"
  default = {
    puppetClasses = "apps_google_connector" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=googleconnector|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_bing_connector" {
  type = "map"
  default = {
    puppetClasses = "apps_bing_connector" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=bingconnector|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_optimization" {
  type = "map"
  default = {
    puppetClasses = "apps_optimization" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=optimization|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_advertiser_service" {
  type = "map"
  default = {
    puppetClasses = "apps_advertiser_service" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=advertiserservice|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_campaign_service" {
  type = "map"
  default = {
    puppetClasses = "apps_campaign_service" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=campaignservice|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "us-opdb" {
  type = "map"
  default = {
    puppetClasses = "base" 
    puppetEnv = "dev_nx1_media"
  }
}

# this is specifically for mediagateway node builds
variable "us-rpdb" {
  type = "map"
  default = {
    puppetClasses = "base" 
    puppetEnv = "dev_nx1_media"
  }
}

# this is specifically for mediagateway node builds
variable "apps_gmb_connector" {
  type = "map"
  default = {
    puppetClasses = "apps_gmb_connector" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=gmbconnector|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_cpi_recommendations_service" {
  type = "map"
  default = {
    puppetClasses = "apps_cpi_recommendations_service"
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=recommendationengine|sub=web"
  }
}

# this is specifically for mediagateway node builds
variable "apps_facebook_shim" {
  type = "map"
  default = {
    puppetClasses = "apps_facebook_shim" 
    puppetEnv = "dev_nx1_media"
    puppetVars = "platform=usa|service=facebookshim|sub=app"
  }
}



# resources resources resources resources resources resources resources resources resources resources resources resources

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

# Create servers
resource "openstack_compute_instance_v2" "cpigateway-usa-web01" {
  name = "cpigateway-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_cpi_gateway_service}"
  user_data = "${file("base/base_init.txt")}"

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
  user_data = "${file("base/base_init.txt")}"

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
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "googleconnector-usa-web01" {
  name = "googleconnector-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_google_connector}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "bingconnector-usa-web01" {
  name = "bingconnector-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_bing_connector}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "optimization-usa-web01" {
  name = "optimization-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_optimization}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "advertiserservice-usa-web01" {
  name = "advertiserservice-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_advertiser_service}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "campaignservice-usa-web01" {
  name = "campaignservice-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_campaign_service}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "us-opdb" {
  name = "us-opdb.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.us-opdb}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_DB"
  }

  network {
    name = "DEV_STOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "us-rpdb" {
  name = "us-rpdb.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.us-rpdb}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_DB"
  }

  network {
    name = "DEV_STOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "gmbconnector-usa-web01" {
  name = "gmbconnector-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_gmb_connector}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}


# Create servers
resource "openstack_compute_instance_v2" "cpirecommendations-usa-web01" {
  name = "cpirecommendations-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_cpi_recommendations_service}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_WDMZ"
  }

  network {
    name = "DEV_WDMZSTOR"
  }

}

# Create servers
resource "openstack_compute_instance_v2" "facebookshim-usa-web01" {
  name = "facebookshim-usa-web01.${var.domain}"
  image_name = "${var.image_name}"
  flavor_id = "2"
  key_pair = "chilyard"
  metadata = "${var.apps_facebook_shim}"
  user_data = "${file("base/base_init.txt")}"

  network {
    name = "DEV_APP"
  }

  network {
    name = "DEV_STOR"
  }

}

