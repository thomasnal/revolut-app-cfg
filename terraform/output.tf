#
# AWS
#

output "aws_region" {
  value = "${module.kubernetes.aws_region}"
}


#
# Code Build
#

output "code_build_project_name" {
  value = "${module.code-build.project-name}"
}


#
# Container Registry
#

output "ecr_repo_url" {
  value = "${module.container-registry.ecr_repo_url}"
}


#
# Database
#

output "db_address" {
  description = "The address of the RDS instance"
  value       = "${module.database.db_address}"
}

output "db_endpoint" {
  description = "The connection endpoint"
  value       = "${module.database.db_endpoint}"
}

output "db_name" {
  description = "The database name"
  value       = "${module.database.db_name}"
}

output "db_username" {
  description = "The master username for the database"
  value       = "${module.database.db_username}"
}

output "db_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = "${module.database.db_password}"
}

output "db_port" {
  description = "The database port"
  value       = "${module.database.db_port}"
}


#
# Kubernetes Cluster
#

output "config_map_aws_auth" {
  value = "${module.kubernetes.config_map_aws_auth}"
}

output "kubeconfig" {
  value = "${module.kubernetes.kubeconfig}"
}
