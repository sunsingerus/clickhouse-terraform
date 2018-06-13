
output "ip_ch_node_multiple" {
  value = ["${aws_instance.ch_node_multiple.*.public_ip}"]
}
