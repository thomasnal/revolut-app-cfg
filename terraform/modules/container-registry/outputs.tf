#
# Outputs
#

output "ecr_repo_url" {
  value ="${aws_ecr_repository.revolut-app.repository_url}"
}
