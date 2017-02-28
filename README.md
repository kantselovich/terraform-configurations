![picture alt](https://deepstream.io/blog/deployment-using-terraform/terraform.png)

## ***Configuration and Installation*** ##


#### Go Notes ####



#### Terraform Notes ####

modules have context.  vars of the same name under different modules may coexist

directory structure - what's the best way to organize for the user readability and keep it DRY?   
/                   # root module" - has root module context  
modules /         # these have individual module context    
    dev-usa /  
      nodes / 
      libs /  
      dns /  
      apps /  


#### Terraform-provider-netscaler Notes ####

i had an issue when building off the hashicorp/terraform master and using the citrix-terraform-netscaler plugin.  had to
use an older tagged version of hashicorp/terraform as there was an API version conflict w/ the terraform-provider-netscaler 
plugin and terraform

  * DNS names - seems like the terraform-provider-netscaler won't accept FQDN, only IP (gah)


#### Environment Configuration ####

git stuff
* ignore ./.terraform (folder)
* ignore bin

Go environment vars
* export PATH=$PATH:~/go/bin
* export GOROOT=~/go
* export GOPATH=~/go/work

Terraform environment vars
* export TF_LOG="TRACE"   # set the amount of logging you want when running terraform  



## HowTo ##  
to create your own use a different environment buildout simply switch the link from the current "environment ->" to the 
environment you'd like to build out.  e.g.
environment -> dev_nx1_rs
