data "aws_iam_policy_document" "profile-email-notification-queue-policy-document" {
  statement {
    sid = "EnableMessageSendingToQueueFromProfilesTopic"
    effect = "Allow"
    actions = [
      "sqs:SendMessage"]

    principals {
      identifiers = ["*"]
      type = "AWS"
    }

    resources = [aws_sqs_queue.profile-email-notification-queue.arn]

    condition {
      test     = "ArnEquals"
      values   = [var.profiles_topic_arn]
      variable = "aws:SourceArn"
    }
  }
}

resource "aws_sqs_queue_policy" "profile-email-notification-policy" {
  policy = data.aws_iam_policy_document.profile-email-notification-queue-policy-document.json
  queue_url = aws_sqs_queue.profile-email-notification-queue.id
}

resource "aws_sqs_queue" "profile-email-notification-queue" {
  name = "profile-email-notification-queue"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.profile-email-notification-dl-queue.arn
    maxReceiveCount     = 1
  })
}

resource "aws_sqs_queue" "profile-email-notification-dl-queue" {
  name = "profile-email-notification-dl-queue"
}

resource "aws_sns_topic_subscription" "profile-email-notification-subscription" {
  endpoint             = aws_sqs_queue.profile-email-notification-queue.arn
  protocol             = "sqs"
  topic_arn            = var.profiles_topic_arn
  raw_message_delivery = true
}