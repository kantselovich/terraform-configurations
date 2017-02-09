# Required configs for Go and Terraform

# i had an issue when building off the hashicorp/terraform master and using the citrix-terraform-netscaler plugin.  had to
# use an previous tagged revision of hashicorp/terraform as there was an API revision issue


# environment vars
export PATH=$PATH:~/go/bin
export GOROOT=~/go
export GOPATH=~/go/work
export TF_LOG="blah"


# git
ignore ./.terraform (folder)


# modules structure
/ ("root module")
  modules /
    dev-usa /
      nodes /
      lbs /
      dns /
      apps /
    dev-can /
    dev-gbr /
    dev-eur /
    dev-aus /
    dev-jpn /

    qa-usa /
    qa-can /
    qa-gbr /
    qa-eur /
    qa-aus /
    qa-jpn /
  
    stg-usa /
    stg-can /
    stg-gbr /
    stg-eur /
    stg-aus /
    stg-jpn /
  
    prod-usa /
    prod-can /
    prod-gbr /
    prod-eur /
    prod-aus /
    prod-jpn /

