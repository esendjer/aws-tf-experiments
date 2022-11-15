# Policy for FullAccessAdminGroup
data "aws_iam_policy_document" "assume_policy_full_access_admin_group" {
  statement {
    sid       = "tfManaged"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]

    condition {
      test     = "StringEquals"
      variable = "iam:ResourceTag/AllowedToAssumeFor"
      values   = ["Admins"]
    }
  }
}

resource "aws_iam_policy" "assume_policy_full_access_admin_group" {
  name        = "AssumeFullAccessAdminPolicy"
  description = "Policy allows to assume AssumeFullAccessAdminRole"

  policy = data.aws_iam_policy_document.assume_policy_full_access_admin_group.json
}

# Policies for AssumeFullAccessAdminRole
data "aws_iam_policy_document" "trusted_entities_full_access_admin_role" {
  statement {
    sid        = "tfManaged"
    actions    = ["sts:AssumeRole"]
    principals {
        type        = "AWS"
        identifiers = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

data "aws_iam_policy_document" "full_access_admin_role" {
  statement {
    sid       = "tfManaged"
    actions   = ["*"]
    resources = ["*"]
  }
}

# Policy for Users (IAMUserSelfManage)
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage-pass-accesskeys-ssh.html
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html
data "aws_iam_policy_document" "iam_user_self_manage" {
  statement {
    sid = "AllowCreateVirtualMFADevice"
    actions = [
      # MFA
      "iam:CreateVirtualMFADevice"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/$${aws:username}"
    ]
  }
  statement {
    sid = "AllowManageOwnPasswordsMFAAccessKeys"
    actions = [
      # Allows users to change their Password and get info about themselves such as ARN
      "iam:ChangePassword",
      "iam:GetUser",
      # Allows users to manage their MFA Devices except removing and deactivating them
      "iam:ListMFADevices",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:ListVirtualMFADevices",
      # Allows users to manage their Access Keys
      "iam:*AccessKey*",
      # Allows users to change their password on their own user page
      "iam:GetLoginProfile",
      "iam:UpdateLoginProfile",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}"]
  }
  statement {
    sid = "AllowViewAccountInfo"
    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam_user_self_manage" {
  name        = "IAMUserSelfManage"
  description = "Policy allows users to manage their Passwords, Access Keys, MFA Devices"

  policy = data.aws_iam_policy_document.iam_user_self_manage.json
}