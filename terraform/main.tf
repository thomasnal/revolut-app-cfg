#
# Builds
# * Kubernetes Cluster
# * Container Image Repository
# * Database
#

module "kubernetes" {
  source = "./modules/kubernetes"
}

module "container-registry" {
  source = "./modules/container-registry"
}

module "database" {
  source = "./modules/database"
  aws_security_group_node_id = "${module.kubernetes.aws_security_group_node_id}"
  aws_vpc_id = "${module.kubernetes.aws_vpc_id}"
}

module "code-build" {
  source = "./modules/code-build"
  ecr_repo_url = "${module.container-registry.ecr_repo_url}"
}
