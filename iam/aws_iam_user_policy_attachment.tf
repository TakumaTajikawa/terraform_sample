resource "aws_iam_user_policy_attachment" "deploy-attach" {
    # ポリシーをアタッチするための対象ユーザーの名前を指定している
    user = aws_iam_user.deploy-user.name
    # アタッチするポリシーのarn(Amazon Resource Name)を指定している
    policy_arn = aws_iam_policy.deploy.arn 
}
