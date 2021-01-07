resource "aws_sns_topic" "profiles-topic" {
  name = "profiles"

  sqs_failure_feedback_role_arn = aws_iam_role.profiles-topic-logging-role.arn
  sqs_success_feedback_role_arn = aws_iam_role.profiles-topic-logging-role.arn
  sqs_success_feedback_sample_rate = 100
}