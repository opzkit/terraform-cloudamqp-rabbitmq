variable "name" {
  type        = string
  description = "Name of instance"
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
  type        = list(string)
  description = "List of email recipients for alerts"
  default     = []
}

variable "slack_webhooks" {
  type        = list(string)
  description = "List of Slack webhooks which will be called for alerts"
  default     = []
}
