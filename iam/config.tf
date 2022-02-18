terraform {
    backend "s3" {
        bucket = "terraform-3211-2051-3547"
        key = "terraform-sample/iam/terraform.tfstate"
        region = "ap-northeast-1" 
    }
}

provider "aws" {
    region = "ap-northeast-1"
}