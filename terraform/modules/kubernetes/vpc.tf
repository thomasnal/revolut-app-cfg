#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "revolut-app" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
      "Name", "eks-revolut-app",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "revolut-app" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.revolut-app.id}"

  tags = "${
    map(
      "Name", "eks-revolut-app",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "revolut-app" {
  vpc_id = "${aws_vpc.revolut-app.id}"

  tags = {
    Name = "eks-revolut-app"
  }
}

resource "aws_route_table" "revolut-app" {
  vpc_id = "${aws_vpc.revolut-app.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.revolut-app.id}"
  }
}

resource "aws_route_table_association" "revolut-app" {
  count = 2

  subnet_id      = "${aws_subnet.revolut-app.*.id[count.index]}"
  route_table_id = "${aws_route_table.revolut-app.id}"
}
