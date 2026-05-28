variable "name" {
  type        = string
  description = "Name of instance"
}

variable "secret_name" {
  type        = string
  default     = null
  description = "Name of secret, defaults to mq/rabbit/<instance name>"
}

variable "plan" {
  type        = string
  description = "Plan for instance"
}

variable "nodes" {
  type        = number
  default     = null
  description = "Number of instances for plan. *Deprecated* see https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/instance#nodes"
}

variable "region" {
  type        = string
  description = "Region where instance will be located"
}

variable "rmq_version" {
  type        = string
  description = "Version of RabbitMQ to use"
  default     = "3.8.8"
}

variable "email_recipients" {
  type        = map(string)
  description = "Map of email recipients for alerts. Key is the recipient name shown in the cloudamqp UI, value is the email address."
  default     = {}
}

variable "slack_webhooks" {
  type        = map(string)
  description = "Map of Slack webhooks called for alerts. Key is the recipient name shown in the cloudamqp UI, value is the webhook URL."
  default     = {}
}

variable "teams_webhooks" {
  type        = map(string)
  description = "Map of Teams webhooks called for alerts. Key is the recipient name shown in the cloudamqp UI, value is the webhook URL."
  default     = {}
}

variable "consumer_alarm_queue_regex" {
  type        = string
  description = "Queue regex to determine which queues should be monitored"
  default     = ".*"
}

variable "queue_alarm_queue_regex" {
  type        = string
  description = "Queue regex to determine which queues should be monitored"
  default     = ".*"
}

variable "cpu_alarm_threshold" {
  type        = number
  description = "Threshold for CPU alarm. Only for dedicated instances. If no value is provided, no alarm will be setup"
  default     = null
}

variable "mem_alarm_threshold" {
  type        = number
  description = "Threshold for memory alarm. Only for dedicated instances. If no value is provided, no alarm will be setup"
  default     = null
}

variable "disk_alarm_threshold" {
  type        = number
  description = "Threshold for disk alarm. Only for dedicated instances. If no value is provided, no alarm will be setup"
  default     = null
}

variable "consumer_alarm_time_threshold" {
  type        = number
  description = "Time in seconds for consumer alarm, default to 60 secs."
  default     = 60
}
