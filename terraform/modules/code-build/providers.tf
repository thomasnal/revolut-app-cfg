#
# Provider Configuration
#

provider "aws" {
  region = "eu-west-2"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}
