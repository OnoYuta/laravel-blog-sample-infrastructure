resource "aws_ecs_cluster" "laravel-blog-sample-cluster" {
  name               = "$(var.project_name)-cluster"
}