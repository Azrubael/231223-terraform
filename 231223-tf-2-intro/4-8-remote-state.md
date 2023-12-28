# 2023-12-27    18:16
=====================

8. Remote state
---------------

Terraform keeps the remote state of the infrastructure.
It storoes in in files called 'terraform.tfstate' and 'terraform.tfstate.backup' where terraform keeps track of the remote state.
When you execute terraform *apply*, new 'terraform.tfstate' and 'terraform.tfstate.backup' is written.

If the remote state changes and you hit 'terraform apply' again, terraform will make changes to meet the *correct remote state* again.
E.g. if you terminate an instance that is managed by terraform, after 'terraform apply' that instance will be *started* again because if you terminate an instance manually, the instance is gone, and then when you do 'terraform apply', terraform will notice that instance doesn't exist anymore and terraform will just launch it again.

You can keep 'terraform.state' in a *version control system*, and it gives you a history of 'terraform.state' file which is actually just a big JSON. An it allows you to *collaborate* with other team members.
    BUT you can cat conflicts when 2 or more people wotk with 'terraform.state' at the same time. You always need to do a "git push" and "git pull" just to make shure that you are on the latest version.

Local state works well in the beginning, but when your project becomes bigger, you might want to store your state *remote*.

The 'terraform.state' can be saved remote using the *backend* functionality in terraform. The default is a *local backend*. Other backends include:
- s3 (with locking mechanism using DynamoDB);
- consul (with locking);
- terraform enterprise (the commercial solution).

Using the *backend* functionality has definitely benifits:
- working in a team (it allows for collabration). With s3 or consul locking the remote state will always be available for the whole team;
- possible *sensitive information* is _only_ stored in the remote state;
- some backends will enabl *remote operations*. The 'terraform apply' will then run completely remote. These are called the enhanced bachends
[https://www.terraform.io/docs/backends/types/index.html]

# 2 steps to configure a remote state:
- add backend code to a *.tf file;
- run the initialization process.

    $ vim backend.tf
#-------------------------
terraform {
    backend "consul" {
        # hostname of consul cluster
        address = "bemo.consul.io"
        # where consul cluster will be stored
        path = "terraform/myproject"
    }
}
#-------------------------

# OR
    $ vim backend.tf
#-------------------------
terraform {
    backend "s3" {
        bucket = "mybucket"
        key = "terraform/myproject"
        region = "us-east-1"
    }
}
#-------------------------
    $ aws configure
# bacause yo cannot use variables in s3 backend configuration, only in a later stage of terraform

# NEXT STEP
    $ terraform init


Using a *remote* store for the terraform state ensure that you always have the *latest version* of the state. It avoids having to *commit* and *push* 'terraform.tfstate' to your version control system.
s3 and consul stores support *locking*, BUT terraform remote stores don't alwys support *locking*, the documentation always mentions if locking is available for a remote store.


# READ-only store (it's a datasource)
data "terraform_remote_state" "aws-state" {
    backend = "s3"
    config {
        bucket = "terraform-store"
        key = "terraform.tfstate"
        access_key = "${var.AWS_ACCESS_KEY}"
        secret_key = "${var.AWS_SECRET_KEY}"
        region = "${var.REGION}"
    }
}

