# Sample Fargate with Terraform

This repository contains two Terraforrm Modules in the `modules/` directory, the first module `fargate-cluster` creates all the support infrastructure for our service, VPC, subnets, security groups, etc along with a Fargate/ECS cluster. The second module, `fargate-service` can be used to deploy a container into a Fargate service on this cluster.

The root of the repos also contains a sample configuration which uses these two modules to create a Fargate cluster and a single service using a sample application. To start up this infrastrucutre on your own AWS account, do the following steps.

1. Authenticate your shell with your AWS account, export your access keys as environment variables, or use AssumeRole using whatever tools you have avaliable locally.
2. Line 34 in the `main.tf` file at the root of the repo, is where the container image that will be deployed is configured. Change that image to one of your own, or use [default image](https://github.com/jasondewitt/sample-service) included in this project. 
3. One the TF file is ready, issue a `terraform plan` command and look over the plan and make sure you agree with what is about to happen. When you are happy with the plan, run the `terraform apply` command. A second plan will be generated, but this time you will be asked if you want to apply the plan, enter 'yes'
4. The infrastructure will take around 10 minutes to be built on AWS. Once terraform has completed provisioning the services it will output the URL for our Fargate service on the command line:

```:bash
Apply complete! Resources: 39 added, 0 changed, 0 destroyed.

Outputs:

sample-url = http://fargate-tfargate-sample-alb-490350291.us-west-2.elb.amazonaws.com
```

Open that URL in your browser and you should see that our Fargate service is live.

5. If you want to update the service with a newer version of your Container, the process exactly the same as before. Edit the `main.tf` file to specify the container we want to run, more containers are avaliable in the [GitHub Package Registry](https://github.com/users/jasondewitt/packages/container/package/sample-service) for my sample-service repo.

6. Again, when you are happy with the edits to the Terraform configuration, go through the process of running `terraform plan` and `terraform apply` to apply your changes to AWS.