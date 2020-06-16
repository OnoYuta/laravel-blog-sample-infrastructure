resource "aws_ecs_cluster" "laravel-blog-sample-cluster" {
  name               = "$(var.project_name)-cluster"
}

resource "aws_ecs_service" "webapp-service" {
  name               = "webapp-service"
  cluster            = aws_ecs_cluster.laravel-blog-sample-cluster.id
  # TaskDefinitionのarnを指定する
  task_definition    = aws_ecs_task_definition.laravel-blog-sample-task.arn
  # TaskDefinitionを実行するインスタンスの数
  desired_count      = 1
  # サービスを実行するタイプをEC2かFargateで指定する
  launch_type        = "EC2"
}

resource "aws_ecs_task_definition" "laravel-blog-sample-task" {
  family                = "webapp-service"
  container_definitions = file("container_definitions/service.json")
  task_role_arn         = aws_iam_role.ecs_task_role.arn
  network_mode          = "bridge"
}