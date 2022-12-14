name                = "gitlab-app"
region              = "eu-central-1"
environment         = "test"
cidr                = "10.0.0.0/16"
availability_zones  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
private_subnets     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
public_subnets      = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
container_memory    = 512
container_cpu       = 256
container_port      = 8080
desired_tasks       = 1
domain              = "kruta.link"
