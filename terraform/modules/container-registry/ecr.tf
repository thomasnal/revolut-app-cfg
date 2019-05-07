#
# ECR Resources
#   * Repository
#

resource "aws_ecr_repository" "revolut-app" {
  name = "revolut-app"
}
