resource "aws_security_group" "instance" {

    # セキュリティグループの名前
    name = "instance"

    # セキュリティグループの説明
    description = "instance sg"

    # セキュリティグループリソースを作成するVPCを指定している
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        security_groups = [
            aws_security_group.alb.id,
        ]
    }

    # セキュリティグループから外に出る通信のポート範囲の対象IPを指定している
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "alb" {
    name = "sample-rails-alb"
    description = "http and https"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    
    ingress { 
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "db" {
    name = "sample-db"
    description = "DB"
    vpc_id = data.terraform_remote_state.vpc.vpc_id 
    
    ingress { 
        from_port = 3306
        to_port = 3306
        protocol = "tcp"

        security_groups = [
            aws_security_group.instance.id,
        ]
    }
}
