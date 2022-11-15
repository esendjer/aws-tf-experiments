data "aws_iam_policy_document" "apigateway_assume" {
  statement {
    sid = "TFAPIGatewayAssume"
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "api_gateway_valdevops_project_creation_stepfunction" {
  name               = "APIGatewayToProjectCreationStepFunction"
  assume_role_policy = data.aws_iam_policy_document.apigateway_assume.json
}

data "aws_iam_policy_document" "logging" {
  statement {
    sid = "TFLogging"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents",
        "logs:GetLogEvents",
        "logs:FilterLogEvents",
        ]
    effect = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "statemachine" {
  statement {
    sid = "TFStateMachine0"
    actions = [
        "states:SendTaskSuccess",
        "states:ListStateMachines",
        "states:SendTaskFailure",
        "states:ListActivities",
        "states:SendTaskHeartbeat",
        ]
    effect = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "TFStatemMchine1"
    actions = [
        "states:*",
        ]
    effect = "Allow"
    resources = [
        "arn:aws:states:us-east-1:777706073360:stateMachine:*",
        "arn:aws:states:us-east-1:777706073360:activity:*",
        "arn:aws:states:us-east-1:777706073360:execution:*:*",
    ]
  }
}

resource "aws_iam_policy" "allow_write_logs" {
  name   = "AllowWriteLogs"
  policy = data.aws_iam_policy_document.logging.json
}

resource "aws_iam_policy" "allow_execute_statemachine" {
  name   = "AllowExecuteStateMachine"
  policy = data.aws_iam_policy_document.statemachine.json
}

resource "aws_iam_role_policy_attachment" "attach_allow_write_logs" {
  role       = aws_iam_role.api_gateway_valdevops_project_creation_stepfunction.name
  policy_arn = aws_iam_policy.allow_write_logs.arn
}

resource "aws_iam_role_policy_attachment" "attach_allow_execute_statemachine" {
  role       = aws_iam_role.api_gateway_valdevops_project_creation_stepfunction.name
  policy_arn = aws_iam_policy.allow_execute_statemachine.arn
}

################################################

data "aws_iam_policy_document" "valdevops_statemachine_assume" {
  statement {
    sid = "TFValDevOpsStateMachineAssume"
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "valdevops_statemachine_create_project" {
  name               = "tf-valdevops-statemachine-create-project"
  assume_role_policy = data.aws_iam_policy_document.valdevops_statemachine_assume.json
}

data "aws_iam_policy_document" "valdevops_statemachine_invoke_lambdas" {
  statement {
    sid = "TFValDevOpsStateMachineInvokeLambdas"
    actions = ["lambda:InvokeFunction"]
    effect = "Allow"
    resources = flatten([
      [for larn in aws_lambda_function.stetemachine_lambdas : format("%s:*", larn.arn)],
      [for larn in aws_lambda_function.stetemachine_lambdas : format("%s", larn.arn)]
    ])
  }
  depends_on = [
    aws_lambda_function.stetemachine_lambdas
  ]
}

resource "aws_iam_policy" "valdevops_statemachine_invoke_lambdas" {
  name   = "TFValDevOpsStateMachineInvokeLambdas"
  policy = data.aws_iam_policy_document.valdevops_statemachine_invoke_lambdas.json
}

resource "aws_iam_role_policy_attachment" "valdevops_statemachine_invoke_lambdas" {
  role       = aws_iam_role.valdevops_statemachine_create_project.name
  policy_arn = aws_iam_policy.valdevops_statemachine_invoke_lambdas.arn
}
