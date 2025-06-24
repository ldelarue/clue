# Configure the GitHub Provider
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6.0"
    }
  }
  required_version = ">= 1.0"
}

provider "github" {
  # Configuration options
  token = var.github_token
  owner = var.organization_name
}
