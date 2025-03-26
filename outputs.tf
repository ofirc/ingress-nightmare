output "demo_name" {
  value = local.demo_name
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "update_kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}

output "port_forward_command" {
  value = "kubectl port-forward svc/ingress-nginx-controller-admission -n ingress-nginx 8443:443"
}

output "validate_command" {
  value = "curl -vk https://localhost:8443/validate -H \"Content-Type: application/json\" --data-binary @admission-review.json"
}
