resource "aws_lb" "lb" {
    # ロードバランサの名前
    name = "sample-lb"

    # 内部向けロードバランサにするか
    internal = false

    # ロードバランサーのタイプ
    load_balancer_type = "application"

    security_groups = [
        aws_security_group.alb.id,
    ]

    subnets = [
        data.terraform_remote_state.vpc.outputs.public_subnet_1_id,
        data.terraform_remote_state.vpc.outputs.public_subnet_2_id,
    ]
}
