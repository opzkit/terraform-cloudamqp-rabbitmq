module "rabbitmq" {
  source         = "../../"
  region         = "eu-west-1"
  name           = "name"
  secret_name    = "cloudamqp"
  plan           = "lemur"
  nodes          = 1
  teams_webhooks = []
}
