
output "ip_ch_node_1" {
  value = "${aws_instance.ch_node_1.public_ip}"
}

output "id_ch_ebs_volume_1" {
  value = "${aws_ebs_volume.ch_ebs_volume_1.id}"
}

output "arn_ch_ebs_volume_1" {
  value = "${aws_ebs_volume.ch_ebs_volume_1.arn}"
}

