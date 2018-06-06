
#output "ip_server_1" {
#  value = "${aws_instance.my_server_1.public_ip}"
#}
#
#output "ip_server_2" {
#  value = "${aws_instance.my_server_2.public_ip}"
#}
#
#output "ip_server_3" {
#  value = "${aws_instance.my_server_3.public_ip}"
#}
#
#output "elb_dns_name" {
#  value = "${aws_elb.my_elb_1.dns_name}"
#}


output "ip_ch_node_multiple" {
  value = ["${aws_instance.ch_node_multiple.*.public_ip}"]
}
