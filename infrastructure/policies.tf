//data "aws_iam_policy_document" "email-notification-service-policy-document" {
//  statement {
//    effect = "Allow"
//    actions = [
//      "ses:SendRawEmail",
//      "sqs:ReceiveMessage"]
//    resources = [
//      "*"]
//  }
//}
//
//
//resource "aws_iam_role-policy" "email-notification-service-policy" {
//  name = "EmailNotificationServicePolicy"
//  policy = data.aws_iam_policy_document.email-notification-service-policy-document.json
//}
//
//resource "aws_iam_policy" "profile-service-policy" {
//  name = "ProfileServicePolicy"
//  policy = data.aws_iam_policy_document.profile-service-policy-document.json
//}