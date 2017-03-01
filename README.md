![picture alt](https://deepstream.io/blog/deployment-using-terraform/terraform.png)

## ***Configuration and Installation*** ##


#### Go Notes ####



#### Terraform Notes ####

* modules have context.  vars of the same name under different modules may coexist
* directory structure - what's the best way to organize for the user readability and keep it DRY?   
/ (root module - has root module context)  
base / (base module - common components)
bin / (i put the compiled terraform binary here)
main.tf (this is the first tf file found by terraform - best case scenario is we edit this file as our main config)

#### Terraform-provider-netscaler Notes ####

i had an issue when building off the hashicorp/terraform master and using the citrix-terraform-netscaler plugin.  had to
use an older tagged version of hashicorp/terraform as there was an API version conflict w/ the terraform-provider-netscaler 
plugin and terraform

  * DNS names - seems like the terraform-provider-netscaler won't accept FQDN, only IP.  the workaround here is to set a dependency
  on the node being created for the lb vserver.  the lb vserver won't be created until the node is built and the nodes ip is set.


#### Environment Configuration ####

git stuff
* clone https://github.com/chuck-hilyard/terraform-configurations

Go environment vars
* export PATH=$PATH:~/go/bin
* export GOROOT=~/go
* export GOPATH=~/go/work

Terraform environment vars
* export TF_LOG="TRACE"   # set the amount of logging you want when running terraform  



#### HowTo
to create your own use a different environment buildout - simply switch the link from the current "environment ->" to the 
environment you'd like to create.  e.g.  

environment -> dev_nx1_rs
