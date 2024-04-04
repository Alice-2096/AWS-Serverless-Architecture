output "curl_command" {
  value = "curl -X POST https://${var.domain_name}/${var.path}"
}
