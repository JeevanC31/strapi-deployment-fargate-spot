## TASK-9: Strapi Deployment using AWS ECS Fargate Spot (CI/CD + Terraform)
 Project Overview:-

# This project demonstrates automated deployment of a Dockerized Strapi application on AWS using:

- Docker
- Amazon ECR
- Amazon ECS (FARGATE_SPOT)
- Terraform (Infrastructure as Code)
- GitHub Actions (CI/CD)

## Architecture Flow

- Code is pushed to main branch.
- GitHub Actions CI workflow:
      - Builds Docker image
      - Logs into Amazon ECR
      - Pushes image to ECR

- Terraform workflow:
      - Creates ECS Cluster
      - Creates Task Definition
      - Creates ECS Service using FARGATE_SPOT

- ECS pulls the image from ECR.

- Strapi runs on a public IP.

## Project Structure
```text
.
├── .github/workflows/
│   ├── ci.yml
│   ├── terraform.yml
│   └── destroy.yml
│
├── strapi-app/
│   ├── Dockerfile
│   └── Strapi source code
│
├── terraform/
│   ├── ecs.tf
│   ├── ecr.tf
│   ├── provider.tf
│   └── variables.tf
│
└── README.md
```
# ECS Configuration

- Launch Type: FARGATE_SPOT
- CPU: 512
- Memory: 1024
- Network Mode: awsvpc
- Public IP: Enabled
- Capacity Provider: FARGATE_SPOT

- Access the Application

- After successful deployment:

- Admin panel:
```bash
http://<public-ip>:1337/admin
```