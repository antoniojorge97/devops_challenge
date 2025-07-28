# 🚀 DevOps Challenge – CI/CD Pipeline

This project implements a GitHub Actions-based CI/CD pipeline for deploying a .NET application to AWS ECS Fargate using Terraform. It supports **blue-green deployments**, Docker image builds, and **manual** control over deployment behavior.

---

## 📦 Pipeline Overview

The CI/CD pipeline automates:

- 🧱 Infrastructure provisioning via **Terraform**
- 🧪 .NET build and test
- 🐳 Docker image build and push to **Amazon ECR**
- 🚀 ECS Fargate service update via **blue/green target groups**
- 🛠️ Manual selection of deployment color (`blue` or `green`)

---


## 🧪 Triggering the Pipeline

The pipeline runs on:

- Pushes to the `clean-main` or `develop` branches
- Manual trigger via the GitHub UI (`workflow_dispatch`) with the following inputs:

| Input       | Description                                | Required | Default |
|-------------|--------------------------------------------|----------|---------|
| `color`     | Which target group to deploy to (`blue` or `green`) | ✅       | `blue`  |
| `action`    | Terraform action: `apply` or `destroy`     | ✅       | `apply` |

---

## 🔧 Environment Variables

The following environment variables are defined in the pipeline:

```yaml
AWS_REGION: eu-west-1
AWS_ACCOUNT_ID: 967694737948
ECR_REPOSITORY: devops-challenge-ecr
DOTNET_PROJECT_PATH: src/custom-api/custom-api.csproj
```

# Pipeline Steps

## 1. 🔀 Checkout repository
    Clones the repository to the GitHub Actions runner.

## 2. 🎨 Set deployment color
    Reads the color input (blue or green) from the workflow dispatch and sets it as an environment variable.

## 3. 🔐 Configure AWS credentials
    Authenticates the runner with AWS using GitHub Secrets (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY).

## 4. ⚙️ Set up Terraform
    Installs Terraform version 1.7.5 on the runner.

## 5. 🚀 Terraform Init
    Initializes the Terraform configuration located in the infra/ directory.

## 6. 📦 Terraform Apply or Destroy
    Executes terraform apply or terraform destroy based on user input.

## 7. 🧰 Set up .NET SDK
    Installs .NET SDK version 8.0.x.

## 8. 📅 Restore dependencies
    Runs dotnet restore to install .NET project dependencies.

## 9. 🏗️ Build .NET API
    Compiles the .NET application using the Release configuration.

## 10. Run unit tests
    Executes tests using dotnet test. Skips gracefully if no tests exist.

## 11.🔑 Login to Amazon ECR
    Authenticates Docker CLI with Amazon ECR.

## 12. 🐳 Build Docker image
    Builds the Docker image from images/Dockerfile.

## 13. 🏷️ Tag Docker image
    Tags the Docker image for the ECR repository.

## 14. 📤 Push Docker image to Amazon ECR
    Pushes the tagged image to AWS ECR.

## 15.⏱️ Wait for ECS task to initialize
    Waits 30 seconds to allow ECS service to stabilize and register with the ALB.

## 16. 🟨 Tried to implemnent but without success:

    Get ALB DNS from Terraform
        Retrieves the ALB DNS output to be used in health checks.

    Simple API health check
        Uses curl to validate the API endpoint is returning a 200 OK status.

    Basic load testing
        Simulates traffic load using a curl loop against the deployed service.


# What I would improve:
    Get rid of user manual input for blue and green target groups and implement a strategy for automatically switch traffic.
    This would work by detecting the current active group by querying the listener: "aws_lb_http_listener_arn", flip the color, terraform apply to inactive target group without switching the traffic,
    wait for a couple of seconds to give ECS time to launch the container, health checking my API (curl the endpoint and checking statusCode) and if healthy, terraform apply to new target group.

    Split the pipeline into 3:
        1. Terraform provisioning or destroying infra
        2. Application build and push to ECR (also add a step to remove the image from ECR)
        3. Traffic switching pipeline with health and rollback steps
    
    This would avoid errors like:
        Terraform destroy not able to destroy ECR because it isn't empty (needs manual deletion) and avoiding pushing to an ECR that doesn't exist.

    Benefits:
        Logic separation
        Easier to understand
        Better performance
        Reusability