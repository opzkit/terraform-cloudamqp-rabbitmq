variable "name" {
  type        = string
  description = "Name of instance"
}

variable "plan" {
  type        = string
  description = "Plan for instance"
}

variable "region" {
  type        = string
  description = "Region where instance will be located"
}

variable "nodes" {
  type        = number
  description = "Number of instances in cluster"
  default     = 0
}

variable "rmq_version" {
  type        = string
  description = "Version of RabbitMQ to use"
  default     = "3.8.8"
}

variable "email_recipients" {
  type        = list(string)
  description = "List of email recipients for alerts"
  default     = []
}

variable "slack_webhooks" {
  type        = list(string)
  description = "List of Slack webhooks which will be called for alerts"
  default     = []
}
