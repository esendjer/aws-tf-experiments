resource "aws_api_gateway_rest_api" "example" {
  body = jsonencode(yamldecode(templatefile("${path.module}/api/gateway.yml", {
    state_machine_arn = aws_sfn_state_machine.sfn_state_machine.arn,
    iam_role = aws_iam_role.api_gateway_valdevops_project_creation_stepfunction.arn
  })))

  name = "example"
  description = "blah-blah"
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.example.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = "example"
}

output "gateway_url" {
  value = {
    "stateMachineArn" = "${aws_sfn_state_machine.sfn_state_machine.arn}"
    "RequestEndpoint" = "${aws_api_gateway_deployment.example.invoke_url}${aws_api_gateway_stage.example.stage_name}/execute-steps"
  }
}