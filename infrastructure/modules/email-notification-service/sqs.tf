resource "aws_sqs_queue" "profile-email-notification-queue" {
  name = "profile-email-notification-queue"
}

resource "aws_sns_topic_subscription" "profile-email-notification-subscription" {

  endpoint = aws_sqs_queue.profile-email-notification-queue.arn
  protocol = "sqs"
  topic_arn = module.profile-service.profiles_topic_arn
}