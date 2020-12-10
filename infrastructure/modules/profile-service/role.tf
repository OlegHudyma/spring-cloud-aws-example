data "aws_iam_policy_document" "profile-service-assume-role-policy-document" {
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

data "aws_iam_policy_document" "profile-service-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "sns:Publish",
      "sns:ListTopics",
      "dynamodb:BatchGetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"]

    resources = [
      aws_dynamodb_table.profiles-db.arn,
      aws_sns_topic.profiles-topic.arn]
  }
}

resource "aws_iam_role" "profile-service-role" {
  name = "profile-service-role"

  assume_role_policy = data.aws_iam_policy_document.profile-service-assume-role-policy-document.json
}

resource "aws_iam_policy" "profile-service-policy" {
  name = "profile-service-policy"
  policy = data.aws_iam_policy_document.profile-service-policy-document.json
}

resource "aws_iam_role_policy_attachment" "profile-service-policy-role-attachment" {
  policy_arn = aws_iam_policy.profile-service-policy.arn
  role = aws_iam_role.profile-service-role.name
}