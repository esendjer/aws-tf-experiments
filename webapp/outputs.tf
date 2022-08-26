output "webapp_instances" {
  value = module.aws_webapp_ec2.instances
}

output "dns_name" {
  value = module.aws_webapp_alb.dns_name
}

output "url" {
  value = {
    main       = format("http://%s:80", module.aws_webapp_alb.dns_name),
    redirected = format("http://%s:8080", module.aws_webapp_alb.dns_name)
  }
}
