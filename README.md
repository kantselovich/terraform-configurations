## Configuration and Installation for Terraform, Go, and Terraform Providers ##


#### Go Notes ####



#### Terraform Notes ####



#### Terraform-provider-netscaler Notes ####
i had an issue when building off the hashicorp/terraform master and using the citrix-terraform-netscaler plugin.  had to
use an older tagged version of hashicorp/terraform as there was an API version conflict w/ the terraform-provider-netscaler 
plugin and terraform

  * DNS names - seems like the terraform-provider-netscaler won't accept FQDN, only IP (gah)


#### Environment Configuration ####

Go environment vars
* export PATH=$PATH:~/go/bin
* export GOROOT=~/go
* export GOPATH=~/go/work

Terraform environment vars
* export TF_LOG="TRACE"   # set the amount of logging you want when running terraform  



git stuff
* ignore ./.terraform (folder)
* ignore bin


directory structure - what's the best way to organize for the user readability and keep it DRY? 
/ ("root module")
  modules /
    dev-usa /
      nodes /
      lbs /
      dns /
      apps /
