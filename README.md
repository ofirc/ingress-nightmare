# Ingress Nightmare - Vulnerability Reproducer

This repository contains a Terraform configuration that sets up a Kubernetes cluster and installs ingress-nginx version v4.12.0 to demonstrate the IngressNightmare vulnerability.

## Overview

This setup is a reproducer for the ingress-nginx vulnerability (CVE-2024-24786) discovered and documented by Wiz Research team. You can read more about the vulnerability here:
[Wiz Blog - IngressNightmare: Two 0-day vulnerabilities in Ingress-NGINX](https://www.wiz.io/blog/ingress-nginx-kubernetes-vulnerabilities)

The vulnerability has been fixed in:
- Ingress NGINX Controller version 1.12.1
- Ingress NGINX Controller version 1.11.5

This setup deliberately uses Helm Chart version v4.12.0, setting up the vulnerable ingress-nginx controller v1.12.0 on your cluster which is vulnerable to demonstrate the issue.

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured
- kubectl
- Helm v3

## Configuration

The following variables can be configured:

- `region` - AWS region to deploy to when using EKS (defaults to "us-west-2")
- `ingress_nginx_version` - ingress-nginx Helm Chart version to use (defaults to "4.12.0")

Simply create a `terraform.tfvars` via:
```bash
cp terraform.tfvars.example terraform.tfvars
```

And modify the desired configuration parameters.

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. After applying, Terraform will output the necessary kubectl configuration commands.

5. To verify the ingress-nginx deployment and version:
```bash
# Check the ingress-nginx pods
kubectl get pods --all-namespaces --selector app.kubernetes.io/name=ingress-nginx

# Get the ingress-nginx version
kubectl exec -n ingress-nginx $(kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller -o jsonpath='{.items[0].metadata.name}') -- /nginx-ingress-controller --version
```

6. To validate access to the validation endpoint run the following:
```bash
kubectl port-forward svc/ingress-nginx-controller-admission -n ingress-nginx 8443:443

curl -vk https://localhost:8443/validate -H \"Content-Type: application/json\" --data-binary @admission-review.json
```

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```

Note: If using EKS, make sure to delete any LoadBalancer services before destroying to ensure proper cleanup of AWS resources.

## Security Note

This configuration is intended for educational and testing purposes only. Do not deploy vulnerable versions of ingress-nginx in production environments.
