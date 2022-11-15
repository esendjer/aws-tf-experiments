resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "my-state-machine"
  role_arn = aws_iam_role.valdevops_statemachine_create_project.arn
  # role_arn = "arn:aws:iam::777706073360:role/service-role/StepFunctions-MyStateMachine-role-d8245c8e"

  definition = jsonencode(yamldecode(templatefile("${path.module}/steps/statemachine.yml", {
    first_lambda_arn         = aws_lambda_function.stetemachine_lambdas["first_lambda"].arn,
    second_lambda_arn        = aws_lambda_function.stetemachine_lambdas["second_lambda"].arn,
    error_handler_lambda_arn = aws_lambda_function.stetemachine_lambdas["error_handler_lambda"].arn
  })))
}
