# Terraform and GitLab CI/CD Pipeline for AWS Infrastructure 🌍💻

## Project Overview 📖
This project demonstrates how to use Terraform to deploy AWS infrastructure and integrate it with GitLab CI/CD for automated workflows. It includes the use of remote state management with S3 and DynamoDB for state locking, as well as a modular Terraform setup for efficient resource management.

## Features ✨
- Infrastructure provisioning with Terraform modules.
- AWS resources like VPC, subnets, security groups, and EC2 instances.
- Remote state management using S3 and DynamoDB.
- GitLab CI/CD pipeline automation for validation, planning, and deployment.

## Project Structure 🗂️
```plaintext
├── main.tf          # Root module
├── provider.tf      # AWS provider configuration
├── variables.tf     # Global variable declarations
├── vpc/             # VPC module
│   ├── main.tf      # VPC configuration
│   ├── outputs.tf   # VPC outputs
│   └── variables.tf # VPC variables
├── web/             # EC2 module
│   ├── main.tf      # EC2 configuration
│   ├── outputs.tf   # EC2 outputs
│   └── variables.tf # EC2 variables
├── backend.tf       # Remote backend configuration
└── .gitlab-ci.yml   # GitLab CI/CD pipeline
```

## Terraform Backend Configuration 🔧
```hcl
terraform {
  backend "s3" {
    bucket         = "example-s3-bucket"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}
```

## GitLab CI/CD Pipeline 🚀
The `.gitlab-ci.yml` file automates Terraform workflows.

### CI/CD Stages 🛠️
1. **Validate**: Check Terraform syntax.
2. **Plan**: Generate an execution plan.
3. **Apply**: Apply changes (manual approval required).
4. **Destroy**: Tear down resources (manual approval required).

### Example `.gitlab-ci.yml` 📝
```yaml
stages:
  - validate
  - plan
  - apply
  - destroy

validate:
  image: hashicorp/terraform:latest
  stage: validate
  script:
    - terraform init
    - terraform validate

plan:
  image: hashicorp/terraform:latest
  stage: plan
  script:
    - terraform init
    - terraform plan -out=tfplan
  artifacts:
    paths:
      - tfplan

apply:
  image: hashicorp/terraform:latest
  stage: apply
  script:
    - terraform init
    - terraform apply -auto-approve tfplan
  when: manual

destroy:
  image: hashicorp/terraform:latest
  stage: destroy
  script:
    - terraform init
    - terraform destroy -auto-approve
  when: manual
```

## How to Use 🛠️

### Prerequisites ✅
- Terraform installed locally.
- AWS CLI configured with credentials.
- GitLab project with CI/CD variables:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_DEFAULT_REGION`

### Steps 🏁
1. Clone the repository.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Validate the configuration:
   ```bash
   terraform validate
   ```
4. Deploy the infrastructure:
   ```bash
   terraform apply -auto-approve
   ```
5. Commit and push changes to trigger the GitLab pipeline:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

## Lessons Learned 💡
- Effective use of Terraform modules for scalability.
- Importance of remote state management for collaboration.
- Automating infrastructure deployment using CI/CD pipelines.

## References 📚
- [Terraform Documentation](https://developer.hashicorp.com/terraform)
- [GitLab CI/CD Documentation](https://docs.gitlab.com/ee/ci/)
- [AWS CLI Documentation](https://aws.amazon.com/cli/)

---
**Author:** Suran Sandeepa ✍️

Feel free to explore and contribute! 🎉
