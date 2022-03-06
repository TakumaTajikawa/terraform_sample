resource "aws_ecs_task_definition" "sample-task" {
    # TaskDefinition の名前
    family = "webapp-service"

    # TaskDefinition の定義を指定
    container_definitions = file("./container_definitions/service.json")

    # タスク実行するための IAM ロールの arn を指定
    task_role_arn = data.terraform_remote_state.aws_iam.outputs.ecs_task_role_arn

    # Docker コンテナで使用するネットワークモードを指定。この例では bridge を指定し Docker の組込み仮想ネットワークを使用している
    network_mode = "bridge"
}
