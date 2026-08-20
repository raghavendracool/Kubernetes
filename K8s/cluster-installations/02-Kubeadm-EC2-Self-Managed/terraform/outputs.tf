output "nodes" {
  value = {
    for name, instance in aws_instance.node :
    name => {
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
      id         = instance.id
    }
  }
}
