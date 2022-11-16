resource "aws_iam_user" "web_console_user" {
  name = "web-console-user"
}

resource "aws_iam_user_login_profile" "web_console_user" {
  user                    = aws_iam_user.web_console_user.name
  password_reset_required = true
  lifecycle {
    ignore_changes = [
      password_reset_required,
    ]
  }
}

output "password" {
  value = aws_iam_user_login_profile.web_console_user.password
}
