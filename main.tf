provider "aws" {
  region = "${var.region}"
}

###########
# Instances
###########

resource "aws_instance" "mongo" {
  ami                    = "${var.instance_ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${lookup(var.subnet_ids, var.region)}"
  vpc_security_group_ids = ["${aws_security_group.mongo.id}"]

  provisioner "file" {
    source      = "mongod.conf"
    destination = "/tmp/mongod.conf"
  }

  count = "${var.total_instances}"

  user_data = "${file("script.sh")}"

  tags {
    Name = "${var.instance_prefix}${count.index + 1}"
  }

  associate_public_ip_address = true
  key_name                    = "${var.key_name}"

  connection {
    user        = "${var.instance_user}"
    private_key = "${file(var.private_key)}"
    agent       = false
  }
}

################
# Security Group
################

resource "aws_security_group" "mongo" {
  name   = "${var.sg_name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.sg_name}"
  }
}

###############
# Elastic IP
###############

resource "aws_eip" "mongo" {
  count    = "${var.total_instances}"
  instance = "${element(aws_instance.mongo.*.id, count.index)}"
  vpc      = true
}
