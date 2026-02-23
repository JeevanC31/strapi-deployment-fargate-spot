resource "aws_ecr_repository" "strapi" {
  name = "strapi-repo-jeev"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"
}
