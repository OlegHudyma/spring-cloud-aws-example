data "aws_iam_policy_document" "email-notification-assume-role-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "email-notification-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:ListQueues",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "ses:SendEmail",
      "ses:SendRawEmail"]

    resources = ["*"]
  }
}

resource "aws_iam_role" "email-notification-role" {
  name = "email-notification-role"

  assume_role_policy = data.aws_iam_policy_document.email-notification-assume-role-policy-document.json
}

resource "aws_iam_policy" "email-notification-policy" {
  name = "email-notification-policy"
  policy = data.aws_iam_policy_document.email-notification-policy-document.json
}

resource "aws_iam_role_policy_attachment" "email-notification-policy-role-attachment" {
  policy_arn = aws_iam_policy.email-notification-policy.arn
  role = aws_iam_role.email-notification-role.name
}