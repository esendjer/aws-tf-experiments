# AssumeFullAccessAdminRole
resource "aws_iam_role" "assume_full_access_admin" {
  name               = "AssumeFullAccessAdminRole"
  assume_role_policy = data.aws_iam_policy_document.trusted_entities_full_access_admin_role.json

  tags = {
    "AllowedToAssumeFor" = "Admins"
  }
}

resource "aws_iam_role_policy" "assume_full_access_admin" {
  name = "FullAccessAdminPolicy"
  role = aws_iam_role.assume_full_access_admin.id

  policy = data.aws_iam_policy_document.full_access_admin_role.json
}
