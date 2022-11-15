
resource "aws_lambda_function" "stetemachine_lambdas" {
  for_each = toset([for file in fileset("${path.module}/lambda", "*.py") : trim(file, ".py")])
  
  filename      = "${path.module}/lambda/${each.key}.zip"
  function_name = each.key
  role          = "arn:aws:iam::777706073360:role/service-role/tmp-role-k9zbe9k1"
  handler       = "${each.key}.main"

  source_code_hash = data.archive_file.lambdas_zip[each.key].output_base64sha256

  runtime = "python3.9"
}
