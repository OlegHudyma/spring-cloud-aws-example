data "aws_iam_policy_document" "email-notification-assume-role-policy-document" {
  statement {
    sid    = "EnableAssumeRoleEmailNotificationService"
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

data "aws_iam_policy_document" "email-notification-service-ses-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "ses:SendEmail",
    "ses:SendRawEmail"]

    resources = [
    "*"]
  }
}

data "aws_iam_policy_document" "email-notification-service-sqs-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:ListQueues",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
    "sqs:GetQueueAttributes"]

    resources = [
    "*"]
  }
}

data "aws_iam_policy_document" "email-notification-service-logging-policy-document" {
  statement {
    sid    = "EnableCreationAndManagementOfEmailNotificationServiceLogGroups"
    effect = "Allow"
    actions = [
    "logs:CreateLogGroup"]

    resources = [
    "arn:aws:logs:*"]
  }

  statement {
    sid    = "EnableCreationOfEmailNotificationServiceLogStreamsAndEvents"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
    "logs:PutLogEvents"]

    resources = [
    "${aws_cloudwatch_log_group.email-notification-service-log-group.arn}:log-stream:*"]
  }
}

resource "aws_iam_policy" "email-notification-service-sqs-policy" {
  name   = "email-notification-service-sqs-policy"
  policy = data.aws_iam_policy_document.email-notification-service-sqs-policy-document.json
}

resource "aws_iam_policy" "email-notification-service-ses-policy" {
  name   = "email-notification-service-ses-policy"
  policy = data.aws_iam_policy_document.email-notification-service-ses-policy-document.json
}

resource "aws_iam_policy" "email-notification-service-logging-policy" {
  name   = "email-notification-service-logging-policy"
  policy = data.aws_iam_policy_document.email-notification-service-logging-policy-document.json
}

resource "aws_iam_role" "email-notification-role" {
  name = "email-notification-role"

  assume_role_policy = data.aws_iam_policy_document.email-notification-assume-role-policy-document.json
}

resource "aws_iam_role_policy_attachment" "email-notification-sqs-policy-attachment" {
  policy_arn = aws_iam_policy.email-notification-service-sqs-policy.arn
  role       = aws_iam_role.email-notification-role.name
}

resource "aws_iam_role_policy_attachment" "email-notification-ses-policy-attachment" {
  policy_arn = aws_iam_policy.email-notification-service-ses-policy.arn
  role       = aws_iam_role.email-notification-role.name
}

resource "aws_iam_role_policy_attachment" "email-notification-logging-policy-attachment" {
  policy_arn = aws_iam_policy.email-notification-service-logging-policy.arn
  role       = aws_iam_role.email-notification-role.name
}