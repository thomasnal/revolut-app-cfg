#
# Resources
# * Code Build Project
#

data "template_file" "buildspec" {
  template = "${file("${path.module}/buildspec.yml")}"
  vars = {
    ecr_repo_url = "${var.ecr_repo_url}"
  }
}


module "build" {
    source              = "git::https://github.com/cloudposse/terraform-aws-codebuild.git?ref=master"
    namespace           = "general"
    name                = "revolut-app"
    stage               = "production"

    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    build_image         = "aws/codebuild/docker:1.12.1"
    build_compute_type  = "BUILD_GENERAL1_SMALL"
    build_timeout       = "60"

    artifact_type = "NO_ARTIFACTS"
    source_location = "https://github.com/thomasnal/revolut-app.git"
    source_type = "GITHUB"
    buildspec = "${data.template_file.buildspec.rendered}"

    # These attributes are optional, used as ENV variables when building Docker images and pushing them to ECR
    # For more info:
    # http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html
    # https://www.terraform.io/docs/providers/aws/r/codebuild_project.html

    privileged_mode     = "true"
    image_repo_name     = "${var.ecr_repo_url}"
    image_tag           = "latest"
}
