
output "frontend_public_ip" {
  value = module.frontend_instance.public_ip
}
output "backend_public_ip" {
  value = module.backend_instance.public_ip
}
output "mysql_public_ip" {
  value = module.mysql_instance.public_ip
}
