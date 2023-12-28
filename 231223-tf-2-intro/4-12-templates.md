# 2023-12-28    16:57
=====================

12. Templates
-------------

Let's talk about 'template provider'.
The template provider can help creating *customized configuration files*.
You can build *templates based on variables* from terraform resource attributes (e.g. a public IP address).
The result is a string that can be used as a variable in terraform: the srting contains a template, e.g. a configuration file.
Template provider can be used to create generic templates or cloud init configs.
A "cloud init config" is just a spftware that can read configuration files, when an instance is booted up.

In AWS you can pass commands that needed to be executed when the instance starts for the first time. In AWS this is called "user-data".
If you want to pass user-data that depends on other information in terraform (e.g. IP address), you can use the 'provider template'.

First you can create a template file:
---------------------
#!/bin/bash
echo "database-ip = ${myip}" >> /etc/myapp.comfig
---------------------


Then you can create a 'template_file' resource that will read the template file and replace ${myip} with the address of an AWS instance created by terraform:
---------------------
data "template_file" "my-template" {
    template = "${file(templates/init.tpl)}"
    vars {
        myip = "${aws_instance.database1.private_ip}"
    }
}
---------------------

Then you can use the my-template resource when creating a new instance:
---------------------
# Create a web server
resource "aws_instance" "web" {
    # ...

    user_data = "${data.template_file.my-template.rendered}"
}

When terraform runs, it will see that it first needs to spin up the database1 instance, then generate the template, and only then spin up the web instance (because then it's going to feed this template with this database IP to the web server).
The web instance will have the template injected in the user_data, and when it launches, the user-data will create a file /etc/myapp.config with the IP address of the database.



