# ALB がルーティングする先のターゲットグループ
resource "aws_lb_target_group" "http" {

    # ターゲットグループの名前
    name = "sample-http"

    # ターゲットグループがアクセスする先のポート
    port = 4567

    # ターゲットグループがアクセスするプロトコル
    protocol = "HTTP"

    # ターゲットグループを作成するVPCのID
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    # ヘルスチェック（登録されたターゲットのステータスをテストするため、定期的にリクエストを送信するテストのこと）の設定
    health_check {
        interval = 30
        path = "/health_check"
        port = "traffic-port"
        protocol = "HTTP"
        timeout = 10
        healthy_threshold = 3
        unhealthy_threshold = 3
    }
}
