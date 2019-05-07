#
# Outputs
#

output "db_address" {
  description = "The address of the RDS instance"
  value       = "${module.db.this_db_instance_address}"
}

output "db_endpoint" {
  description = "The connection endpoint"
  value       = "${module.db.this_db_instance_endpoint}"
}

output "db_name" {
  description = "The database name"
  value       = "${module.db.this_db_instance_name}"
}

output "db_username" {
  description = "The master username for the database"
  value       = "${module.db.this_db_instance_username}"
}

output "db_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = "${module.db.this_db_instance_password}"
}

output "db_port" {
  description = "The database port"
  value       = "${module.db.this_db_instance_port}"
}
