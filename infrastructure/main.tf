resource "github_repository" "main_repo" {
  # Basic repository settings
  name        = "clue"
  description = "My personal Web fullstack garden."
  visibility  = "public"
  homepage_url = "https://ldelarue.github.io/clue/"

  # Feature toggles
  has_issues    = true
  has_projects  = false
  has_wiki      = false
  has_downloads = true

  # Merge settings
  allow_merge_commit        = false
  allow_squash_merge        = true
  allow_rebase_merge        = true
  allow_auto_merge          = false
  squash_merge_commit_title = "PR_TITLE"

  # Branch protection defaults
  delete_branch_on_merge = true

  # Security settings
  vulnerability_alerts = true

  pages {
    build_type = "legacy"
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }
}

# Branch protection rule
resource "github_branch_protection" "main_branch" {
  repository_id = github_repository.main_repo.id
  pattern       = "main"

  # Additional security settings
  require_signed_commits  = false
  enforce_admins          = false
  allows_force_pushes     = false
  required_linear_history = true
}