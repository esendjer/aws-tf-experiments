# IAMSelfManageGroup
resource "aws_iam_group" "iam_self_manage" {
  name = "IAMSelfManageGroup"
}

resource "aws_iam_policy_attachment" "iam_self_manage" {
  name       = "iam_self_manage_group_attachment"
  groups     = [aws_iam_group.iam_self_manage.name]
  policy_arn = aws_iam_policy.iam_user_self_manage.arn
}

resource "aws_iam_user_group_membership" "iam_self_manage" {
  user = aws_iam_user.web_console_user.name

  groups = [
    aws_iam_group.iam_self_manage.name,
  ]
}

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