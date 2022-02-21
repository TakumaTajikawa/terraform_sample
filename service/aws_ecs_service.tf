resource "aws_ecs_service" "webapp-service" {
    # ECSサービスの名前
    name = "webapp-service"

    # 作成したECSクラスタのIDを指定
    cluster = aws_ecs_cluster.sample-ecs-cluster.id

    # TaskDefinitionのarnを指定
    task_definition = aws_ecs_task_definition.sample-task.arn

    # TaskDefinition を実行するインスタンスの数を定義
    desired_count = 1

    # サービスを実行するタイプを EC2 か FARGATE を指定
    launch_type = "EC2"

    load_balancer {
        target_group_arn = aws_lb_target_group.http.arn
        container_name = "sample-webapp"
        container_port = "4567"
    }
}
