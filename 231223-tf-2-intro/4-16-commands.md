# 2023-12-29    11:42
=====================

16. Terraform Commands Overview
-------------------------------

Terraform is very much focused on the *resource definitions*.
It has a *limited toolset* available to modify, import and create these definitions.
There is an external tool called *terraforming* that you can use for now (Q4-2016), but it'll take you some time to cinvert your current infrastructure to managed terraform infrastructure (https://github.com/dtan4/terraforming).

terraform apply     - applies state
terraform destroy   - destroys all terraform managed state (CAUTION!)
terreform fmt       - rewrite terraform configuration files to a canonical format and style
terraform get       - downloads and updates modules
terraform graph     - create a visual representation of a configuration or execution plan
terraform output [options] [NAME]       - will try to output any of your resources. With NAME it will only output a specific resource
terraform plan      - show the changes to be made to the infrastrusture
terraform push      - pushes changes to Atlas, Hashicorp's Enterprise tool that can automatically run terraform from a centralized server.
terraform refresh   - refreshes the remote state, can identify differences between state file and remote state.
terraform remote    - configure remote state storage.
terraform show      - show human readdble output from a state or a plan.
terraform state     - a command for advanced state management, e.g. Rename a resource with [terraform state mv aws_instance.example].
terraform taint     - manually makr a resource as tainted, meaning it will be destructed and recreated at the next apply.
terraform validate  - validate your terraform syntax
terraform untaint   - undo a taint.

terraform import [options] ADDRESS ID   - will try and find the infrastructure resource identified with ID and import the state into 'terraform.tfstate' with resource id ADDRESS.
[this means if you have an instances running, but you don't have terraform yet, then you can import the stateusing inport]
# for example:
        terraform import aws_instance.example i-0dfgsdfg6545sr65r6

https://www.terraform.io/docs/providers/aws/instance.html
