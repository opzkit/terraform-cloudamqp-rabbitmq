resource "cloudamqp_instance" "default" {
  name              = var.name
  plan              = var.plan
  region            = "amazon-web-services::${var.region}"
  rmq_version       = var.rmq_version
  nodes             = var.nodes
  no_default_alarms = true
}

resource "cloudamqp_notification" "email" {
  for_each    = toset(var.email_recipients)
  instance_id = cloudamqp_instance.default.id
  type        = "email"
  value       = each.value
}

resource "cloudamqp_notification" "slack" {
  for_each    = toset(var.slack_webhooks)
  instance_id = cloudamqp_instance.default.id
  type        = "slack"
  value       = each.value
}

resource "cloudamqp_notification" "teams" {
  for_each    = toset(var.teams_webhooks)
  instance_id = cloudamqp_instance.default.id
  type        = "teams"
  value       = each.value
}

locals {
  no_default_alarms = length(concat(var.email_recipients, var.slack_webhooks, var.teams_webhooks)) > 0
  recipients = flatten([
    [for i, v in cloudamqp_notification.email : v.id],
    [for i, v in cloudamqp_notification.slack : v.id],
    [for i, v in cloudamqp_notification.teams : v.id]
  ])
}

resource "cloudamqp_alarm" "consumer_alarm" {
  count           = length(local.recipients) > 0 ? 1 : 0
  instance_id     = cloudamqp_instance.default.id
  type            = "consumer"
  enabled         = true
  time_threshold  = 60
  value_threshold = 0
  recipients      = local.recipients
  queue_regex     = var.consumer_alarm_queue_regex
}

resource "cloudamqp_alarm" "queue_alarm" {
  count           = length(local.recipients) > 0 ? 1 : 0
  instance_id     = cloudamqp_instance.default.id
  type            = "queue"
  enabled         = true
  time_threshold  = 30
  message_type    = "total"
  value_threshold = 10
  recipients      = local.recipients
  queue_regex     = var.queue_alarm_queue_regex
}

data "cloudamqp_credentials" "default" {
  instance_id = cloudamqp_instance.default.id
}

resource "aws_secretsmanager_secret" "rabbit" {
  name = "mq/rabbit/${var.secret_name != null && var.secret_name != "" ? var.secret_name : var.name}"
}

resource "aws_secretsmanager_secret_version" "rabbit_value" {
  depends_on    = [cloudamqp_instance.default]
  secret_id     = aws_secretsmanager_secret.rabbit.id
  secret_string = jsonencode(local.secret_value)
}

locals {
  secret_value = {
    AMQP_URL      = cloudamqp_instance.default.url
    AMQP_HOST     = cloudamqp_instance.default.host
    AMQP_VHOST    = cloudamqp_instance.default.vhost
    AMQP_USER     = data.cloudamqp_credentials.default.username
    AMQP_PASSWORD = data.cloudamqp_credentials.default.password
  }
}
