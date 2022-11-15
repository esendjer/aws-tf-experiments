data "archive_file" "lambdas_zip" {
  for_each = toset([for file in fileset("${path.module}/lambda", "*.py") : trim(file, ".py")])
  
  type             = "zip"
  source_file      = "${path.module}/lambda/${each.key}.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/lambda/${each.key}.zip"
}
