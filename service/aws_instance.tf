resource "aws_instance" "sample" {
    # EC2インスタンスを作成するマシンイメージを指定している
    ami = "ami-0e37e42dff65024ae"
    # EC2のインスタンスタイプ
    instance_type = "t2.small"
    # Webコンソールでインスタンスの詳細を表示するかを指定できる。この例ではtrueを指定し、モニタリングを有効にしている
    monitoring = true
    # I AM instance profileを指定。この例ではremote_state経由でecs_instance_profile_nameを参照している
    iam_instance_profile = data.terraform_remote_state.aws_iam.outputs.ecs_instance_profile_name
    # EC2 インスタンスを配置する subnet の id を指定している
    subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_1_id
    # EC2 インスタンスがローンチする時に実行されるファイルを指定。 ECS_CLUSTER をセットするシェルスクリプトを指定している
    user_data = file("./user_data.sh")
    # VPC 内での public な IP アドレスを関連付けるか指定
    associate_public_ip_address = true
    # EC2インスタンスにセットするセキュリティーグループを配列で指定
    vpc_security_group_ids = [ "${aws_security_group.instance.id}", ]

    root_block_device {
        volume_size = "30"
        volume_type = "gp2"
    } 
}
