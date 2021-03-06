resource "aws_iam_user" "deploy-user" {
  name = "deploy-user"
}

resource "aws_iam_policy" "deploy" {
  name        = "deploy"
  path        = "/"
  description = "deploy policy"
  policy      = file("policies/ecr_policy.json")
}

resource "aws_iam_user_policy_attachment" "deploy-attach" {
  user       = aws_iam_user.deploy-user.name
  policy_arn = aws_iam_policy.deploy.arn
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs_instance_role"
  path               = "/"
  assume_role_policy = file("role_policies/ec2_assume_role_policy.json")
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_policy" "ecs_instance_policy" {
  name        = "ecs-instance-policy"
  path        = "/"
  description = "ecs instance policy"
  policy      = file("policies/ecs_instance_policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = aws_iam_policy.ecs_instance_policy.arn
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "ecs-task-role"
  path               = "/"
  assume_role_policy = file("role_policies/ecs_task_assume_role_policy.json")
}

resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecs-task-policy"
  path        = "/"
  description = ""
  policy      = file("policies/ecs_task_policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_attach" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}