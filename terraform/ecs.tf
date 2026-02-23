resource "aws_ecs_cluster" "main" {
  name = "strapi-cluster-jeev-task9"
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task-task9"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = "arn:aws:iam::811738710312:role/ecs_fargate_taskRole"
  task_role_arn      = "arn:aws:iam::811738710312:role/ecs_fargate_taskRole"

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "${aws_ecr_repository.strapi.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "HOST"
          value = "0.0.0.0"
        },
        {
          name  = "PORT"
          value = "1337"
        },
        {
          name  = "APP_KEYS"
          value = "key1,key2,key3,key4"
        },
        {
          name  = "API_TOKEN_SALT"
          value = "randomApiSalt"
        },
        {
          name  = "ADMIN_JWT_SECRET"
          value = "adminSecret"
        },
        {
          name  = "JWT_SECRET"
          value = "jwtSecret"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi-service-task9"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [data.aws_security_group.default.id]
    assign_public_ip = true
  }
}



data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}