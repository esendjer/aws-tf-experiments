# aws-tf-experiments

* [`aws-webapp-alb`](aws-webapp-alb) - creating AWS ALB, is a child module for `webapp`
* [`aws-webapp-ec2`](aws-webapp-ec2) - creating AWS Instances, is a child module for `webapp`
* [`cloud-init`](cloud-init) - rendering cloud-init config, is a child module for `aws-webapp-ec2`
* [`kms-ssh`](kms-ssh) - creating KMS key for SSH, is a child module for `webapp`
* [`webapp`](webapp) - the root module of webapp (web application developed by Hashicorp - https://github.com/hashicorp/learn-go-webapp-demo)