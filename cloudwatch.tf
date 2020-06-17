resource "aws_cloudwatch_log_group" "service-app" {
  name = "${var.project_name}-app"
}