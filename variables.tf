variable "region" {
  description = "Choose The Region where you want to deploy the terraform resources (case sensitive, exclude extra space) examples: us-east-1 us-east-2 us-west-1 us-west-2 ap-east-1 ap-south-1 ap-northeast-2 ap-southeast-1 ap-southeast-2 ap-northeast-1 ca-central-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 eu-north-1 me-south-1 sa-east-1"
  default     = "us-east-1"
}

variable "ingress_nginx_version" {
  description = "Version of the ingress-nginx Helm chart to deploy"
  default     = "4.12.0"
}

locals {
  demo_name = "ingress-nightmare"
}

data "aws_availability_zones" "available" {
  state = "available"
}
