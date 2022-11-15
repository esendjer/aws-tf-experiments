# FullAccessAdminGroup
resource "aws_iam_group" "full_access_admin" {
  name = "FullAccessAdminGroup"
}

resource "aws_iam_policy_attachment" "full_access_admin" {
  name       = "full_access_admin_attachment"
  groups     = [aws_iam_group.full_access_admin.name]
  policy_arn = aws_iam_policy.assume_policy_full_access_admin_group.arn
}

resource "aws_iam_user_group_membership" "full_access_admin" {
  user = aws_iam_user.web_console_user.name

  groups = [
    aws_iam_group.full_access_admin.name,
  ]
}