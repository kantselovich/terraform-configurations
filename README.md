# Required configs for Go and Terraform


# Go requirements #
#
# i had an issue when building off the hashicorp/terraform master and using the citrix-terraform-netscaler plugin.  had to
# use an older tagged version of hashicorp/terraform as there was an API version conflict w/ the terraform-provider-netscaler 
# plugin and terraform


# Terraform notes #


# Terraform-provider-netscaler notes #
#
# DNS names - seems like the terraform-provider-netscaler won't accept FQDN, only IP (gah)

# environment vars
export PATH=$PATH:~/go/bin
export GOROOT=~/go
export GOPATH=~/go/work
export TF_LOG="TRACE" 



# git
ignore ./.terraform (folder)
ignore terraform-provider-netscaler
ignore tools
ignore tf-acc-external-data-source
ignore stringer
ignore gox
ignore terraform


# directory structure - what's the best way to organize for the user readability and keep it DRY? 
/ ("root module")
  modules /
    dev-usa /
      nodes /
      lbs /
      dns /
      apps /
