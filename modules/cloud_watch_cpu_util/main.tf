resource "aws_sns_topic" "sns" {
  name            = "cloud-watch-topic"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "email"
  endpoint  = var.email
}


resource "aws_cloudwatch_metric_alarm" "cpu_80" {
  alarm_name                = "ec2-cpu-80"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.sns.arn]
  ok_actions                = [aws_sns_topic.sns.arn]
  insufficient_data_actions = []

  dimensions = {
    InstanceId = var.ec2_id
  }
}
