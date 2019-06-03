# tw Infrastructure as code

## Introduction:
Objective
This practical assessment is intended to:
- show you can quickly pick up and deploy software stacks
- show off your infrastructure as code skills
- show you can make pragmatic technical tradeoffs given a deadline
- take around 4-6 hours

## The Problem
The developers of the system have made the source code available to you on this URL:
https://github.com/ThoughtWorksInc/infra-problem
The system is written in Clojure and consists of three microservices: a UI and two backend
services.
● quotes which serves a random quote
● newsfeed which aggregates several RSS feeds together
● front-end which calls the two previous services and displays the results

## How to run the code
1. Clone the git repository https://github.com/sriniGalway/tw or use the zip file
2. Ensure that Terraform and aws cli  is installed on the host machine.
3. run the aws_user.sh to create a user, access key, attach the user policy and upload existing ssh public key under the user.
4. $ terraform init - To initialize Terraform
   $ vagrant provision - if you have already run vagrant up and checking for any updates.
5. connect to the load balancer webserver http://http://192.168.33.13/ to check the webserver pages

## Pre-requisite
To begin with we would install Terraform in our workstation.
https://www.terraform.io/downloads.html

Choose the right distribution for the OS and install accordingly.
Ensure we have set the PATH variable for terraform

Ensure we have aws cli in case we need to run the iam creation and api key creation through cli ( we need to have unzip and python 2 version 2.6.5+ or Python 3 version 3.3+)

a.	Download the AWS CLI Bundled Installer
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
b.	Unzip the package.
unzip awscli-bundle.zip
c.	sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

## Steps:
1.	Create an Access Key and Secret Access Key, assign to the appropriate group - ex: AWSDeepRacerCloudFormationAccessPolicy and AmazonVPCFullAccess
./aws_user.sh > aws_user.log

2.	Pass the access key and secret access key into Terraform
We will use the shared aws credential in ~/.aws/credentials for accessing the aws services through terraform
~/.aws/credentials
[prod]
aws_access_key_id = [AWS ACCESS KEY ID]
aws_secret_access_key = [AWS SECRET ACCESS KEY]
aws_default_region="eu-west2"

3.	Initialize terrafrom
This provides a template for running a simple two-tier architecture on Amazon Web services. The premise is that you have stateless app servers running behind an ELB serving traffic.
 $ terraform init
Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (terraform-providers/aws) 2.13.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.13"
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

4. Apply Terraform template
 $ terraform apply -var 'key_name=<Key name>' -var 'public_key_path=<Public key path>'
ex: terraform apply -var 'key_name=prod' -var 'public_key_path=/Users/tw/.ssh/prod.pub'

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:
 aws_elb.web will be created
  + resource "aws_elb" "web" {
      + arn                         = (known after apply)
      + availability_zones          = (known after apply)
      + connection_draining         = false
      + connection_draining_timeout = 300
      + cross_zone_load_balancing   = true
      + dns_name                    = (known after apply)
      + id                          = (known after apply)
      + idle_timeout                = 60
      + instances                   = (known after apply)
      + internal                    = (known after apply)
      + name                        = "terraform-thoughtworks-elb"
      + security_groups             = [
          + "sg-069578a5a77332dce",
        ]
      + source_security_group       = (known after apply)
      + source_security_group_id    = (known after apply)
      + subnets                     = [
          + "subnet-06987c9669c0c9be8",
        ]
      + zone_id                     = (known after apply)

      + health_check {
          + healthy_threshold   = (known after apply)
          + interval            = (known after apply)
          + target              = (known after apply)
          + timeout             = (known after apply)
          + unhealthy_threshold = (known after apply)
        }

      + listener {
          + instance_port     = 80
          + instance_protocol = "http"
          + lb_port           = 80
          + lb_protocol       = "http"
        }
    }

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami                          = "ami-0e8a68ce9aab2b05d"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "prod"
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = "subnet-06987c9669c0c9be8"
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = [
          + "sg-014b37afa05d48750",
        ]

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + iops                  = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Terraform will create all the required resources and provision the vm
After we run terraform apply on this configuration, it will automatically output the DNS address of the ELB. After the instance registers, this should respond with the default nginx web page.

5. Test (in an automated fashion)
+ make test output

Retrieving slingshot/slingshot/0.12.2/slingshot-0.12.2.jar from clojars
All checks (2) succeeded.
cd front-end && lein midje
WARNING: any? already refers to: #'clojure.core/any? in namespace: leiningen.midje, being replaced by: #'leiningen.midje/any?
Retrieving peridot/peridot/0.4.3/peridot-0.4.3.pom from clojars
Retrieving ring-mock/ring-mock/0.1.5/ring-mock-0.1.5.pom from clojars
Retrieving org/clojure/data.codec/0.1.0/data.codec-0.1.0.pom from central
Retrieving org/apache/httpcomponents/httpmime/4.3/httpmime-4.3.pom from central
Retrieving org/apache/httpcomponents/httpcomponents-client/4.3/httpcomponents-client-4.3.pom from central
Retrieving org/apache/httpcomponents/project/7/project-7.pom from central
Retrieving org/apache/httpcomponents/httpclient/4.3/httpclient-4.3.pom from central
Retrieving org/apache/httpcomponents/httpcore/4.3/httpcore-4.3.pom from central
Retrieving org/apache/httpcomponents/httpcomponents-core/4.3/httpcomponents-core-4.3.pom from central
Retrieving org/apache/httpcomponents/httpcore/4.4/httpcore-4.4.pom from central
Retrieving org/apache/httpcomponents/httpcomponents-core/4.4/httpcomponents-core-4.4.pom from central
Retrieving org/clojure/data.codec/0.1.0/data.codec-0.1.0.jar from central
Retrieving org/apache/httpcomponents/httpmime/4.3/httpmime-4.3.jar from central
Retrieving org/apache/httpcomponents/httpcore/4.4/httpcore-4.4.jar from central
Retrieving org/apache/httpcomponents/httpclient/4.3/httpclient-4.3.jar from central
Retrieving ring-mock/ring-mock/0.1.5/ring-mock-0.1.5.jar from clojars
Retrieving peridot/peridot/0.4.3/peridot-0.4.3.jar from clojars
All checks (4) succeeded.
cd quotes && lein midje
WARNING: any? already refers to: #'clojure.core/any? in namespace: leiningen.midje, being replaced by: #'leiningen.midje/any?
yes
All checks (5) succeeded.
cd newsfeed && lein midje

WARNING: any? already refers to: #'clojure.core/any? in namespace: leiningen.midje, being replaced by: #'leiningen.midje/any?
Retrieving http-kit/fake/http-kit.fake/0.2.1/http-kit.fake-0.2.1.pom from clojars
Retrieving http-kit/http-kit/2.1.12/http-kit-2.1.12.pom from clojars
Retrieving robert/hooke/1.3.0/hooke-1.3.0.pom from clojars
Retrieving robert/hooke/1.3.0/hooke-1.3.0.jar from clojars
Retrieving http-kit/fake/http-kit.fake/0.2.1/http-kit.fake-0.2.1.jar from clojars
All checks (11) succeeded.

# Future work
Make some brief recommendations about your approach to ‘future work’. I.e. how would you extend what you have done to a continuous delivery pipeline and a
productionised system. This could take the form of a document or diagrams. Mention how you would engage with the team.

for future,
1. we could extend this by improving the provisioner to execute scripts on remote machine as part of resource creation or destruction or for any failures.
or by pre-baking configured AMIs with Packer.
2. We could have Jenkins setup , once we have any update to terraform template or update on the jar files, it could initiate the terraform apply using the configuration management. 
