# Project plan

./ - Create revolut-admin user and revolut-admin role
  - AKIA6MWWTZEDAKHGTYW2
  - Yf9IHcbcXfbRcSG4uvCMlRABseb91+J+tFQWAgdl

- Create VPC and subnets
  ./ - VPC name tag `revolut-app`
  ./ - VPC address block `172.32.0.0/16`
  ./ - Output VPC ID
  - Subnet address block
    - revolut-app-1 172.32.0.0/20
    - revolut-app-2 172.32.16.0/20
    - revolut-app-3 172.32.32.0/20
  - Create route-tables and internet gateway

- Implement infrastructure provisioning using Terraform (2hrs)
  ./ - AWS VPC
    ./ - create subnet
  ./ - EKS
    ./ - Select AWS region, IAM role, keys
    ./ - Select AWS Master and Node instances
    - Note: Do you need to output SSH keys to login to the instances?
  - RDS
    - Select instance size
  - ECR
    - Docker images repository
    - Build pipeine or knative build
    - Trigger build on tagging and pushing to branch

- Author k8s manifests
  - Deployment
    - Environment variables
      - Database host read config map
      - Database name read config map
      - Database user read secrets
      - Database password read secrets
    - Health check probe
    - Min pods available 1
    - Bonus: Autoscaling
  - Service
    - ELB
  - Bonus: Ingress

- Bonus 1: Test ansible infrastructure
- Bonus 2: Test performance and autoscaling
- Security? Hardening? Selection of Docker image OS? alpine?

- Configure secrets
  - For simplicity, use K8S Secrets together with Ansible Vault
  - Ansible Vault secrets
    - Create k8s secrets from ansible-vault
  - Bonus: provision HashiCorp Vault, Vault-Agent, Vault secrets to environment variables

- Create database and schema?
- AWS HashiCorp Vault? Marketplace?
- Configure performance alerts emails?
- Configure users?

- WebService
  - Author Dockerfile
    - Multi-stage build, copy the compiled binary


# Ansible


# Caveats

### Bad interpreter

Issue,
```
ansible --version
-bash: /usr/local/bin/ansible: /usr/local/opt/python/bin/python2.7: bad interpreter: No such file or directory
```

Solution,
```
brew link --overwrite ansible
```
