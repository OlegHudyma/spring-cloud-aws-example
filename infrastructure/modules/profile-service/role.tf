data "aws_iam_policy_document" "profile-service-assume-role-policy-document" {
  statement {
    sid = "EnableAssumeRoleProfileService"
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

data "aws_iam_policy_document" "profile-service-sns-policy-document" {
  statement {
    sid = "EnableListingTopics"
    effect = "Allow"
    actions = [
      "sns:ListTopics"]

    resources = [
      "*"]
  }

  statement {
    sid = "EnablePublishingToProfilesTopic"
    effect = "Allow"
    actions = [
      "sns:Publish"]

    resources = [
      aws_sns_topic.profiles-topic.arn]
  }
}

resource "aws_iam_policy" "profile-service-sns-policy" {
  name = "profile-service-sns-policy"
  policy = data.aws_iam_policy_document.profile-service-sns-policy-document.json
}

data "aws_iam_policy_document" "profile-service-logging-policy-document" {
  statement {
    sid = "EnableCreationAndManagementOfProfileServiceLogGroup"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup"]

    resources = [
      "arn:aws:logs:*"]
  }

  statement {
    sid = "EnableCreationOfProfileServiceLogStreamsAndEvents"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"]

    resources = [
      "${aws_cloudwatch_log_group.profile-service-log-group.arn}:*"]
  }
}

resource "aws_iam_policy" "profile-service-logging-policy" {
  name = "profile-service-logging-policy"
  policy = data.aws_iam_policy_document.profile-service-logging-policy-document.json
}

data "aws_iam_policy_document" "profile-service-dynamodb-policy_document" {
  statement {
    sid = "EnableDynamoDbCRUD"
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"]

    resources = [
      aws_dynamodb_table.profiles-db.arn]
  }
}

resource "aws_iam_policy" "profile-service-dynamodb-policy" {
  name = "profile-service-dynamodb-policy"
  policy = data.aws_iam_policy_document.profile-service-dynamodb-policy_document.json
}

resource "aws_iam_role" "profile-service-role" {
  name = "profile-service-role"
  assume_role_policy = data.aws_iam_policy_document.profile-service-assume-role-policy-document.json
}

resource "aws_iam_role_policy_attachment" "profile-service-sns-policy-attachment" {
  policy_arn = aws_iam_policy.profile-service-sns-policy.arn
  role = aws_iam_role.profile-service-role.name
}

resource "aws_iam_role_policy_attachment" "profile-service-dynamodb-policy-attachment" {
  policy_arn = aws_iam_policy.profile-service-dynamodb-policy.arn
  role = aws_iam_role.profile-service-role.name
}

resource "aws_iam_role_policy_attachment" "profile-service-logging-policy-attachment" {
  policy_arn = aws_iam_policy.profile-service-logging-policy.arn
  role = aws_iam_role.profile-service-role.name
}

data "aws_iam_policy_document" "profiles-topic-logging-policy-document" {
  statement {
    sid = "EnableSuccessSQSMessageCloudWatchLogging"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutMetricFilter",
      "logs:PutRetentionPolicy"]

    resources = [
      "*"]
  }
}

resource "aws_iam_policy" "profiles-topic-logging-policy" {
  name = "profiles-topic-logging-policy"
  policy = data.aws_iam_policy_document.profiles-topic-logging-policy-document.json
}

data "aws_iam_policy_document" "profiles-topic-assume-role-policy-document" {
  statement {
    sid = "EnableAssumeRoleProfilesTopicLogging"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "sns.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "profiles-topic-logging-role" {
  name = "profiles-topic-role"
  assume_role_policy = data.aws_iam_policy_document.profiles-topic-assume-role-policy-document.json
}

resource "aws_iam_role_policy_attachment" "profiles-topic-logging-policy-attachment" {
  policy_arn = aws_iam_policy.profiles-topic-logging-policy.arn
  role = aws_iam_role.profiles-topic-logging-role.name
}
