#
# VPC Resources
#  * VPC
#  * Subnets
#  x * Internet Gateway
#  * Route Table
#

resource "aws_subnet" "revolut-app-db" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index+2}.0/24"
  vpc_id            = "${var.aws_vpc_id}"

  tags = "${
    map(
      "Name", "rds-revolut-app"
    )
  }"
}
