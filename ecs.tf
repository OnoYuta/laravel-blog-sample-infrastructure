resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_service" "app-service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "EC2"
}

resource "aws_ecs_task_definition" "app" {
  family                = "${var.project_name}-app"
  container_definitions = file("container_definitions/service.json")
  task_role_arn         = aws_iam_role.ecs_task_role.arn
  network_mode          = "bridge"
}