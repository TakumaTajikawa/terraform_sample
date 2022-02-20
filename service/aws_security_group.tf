resource "aws_security_group" "instance" {
    # セキュリティグループの名前
    name = "instance"
    # セキュリティグループの説明
    description = "instance sg"
    # セキュリティグループリソースを作成するVPCを指定している
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    
    # セキュリティグループから外に出る通信のポート範囲の対象IPを指定している
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
