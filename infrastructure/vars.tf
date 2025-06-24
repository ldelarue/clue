variable "github_token" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token"
}

variable "organization_name" {
  type        = string
  description = "Name of GitHub organization"
}
