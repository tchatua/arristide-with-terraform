resource "aws_s3_bucket" "finance" {
    bucket = "finance-05072022"
    tags = {
        Name = "My bucket"
        Environment = "Dev"
        Description = "Finance and Payroll"
    }
}
resource "aws_s3_bucket_object" "finance-2022" {
    content = "./finance/finance-2022.docx"
    key = "finance-2022.docx"
    bucket = aws_s3_bucket.finance.id 
}
data "aws_iam_user" "finance-data" {
  user_name = "lucy"
}
resource "aws_s3_bucket_policy" "finance-policy" {
  bucket = aws_s3_bucket.finance.id
  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "*",
                "Effect": "Allow",
                "Resource": "arn:aws:s3:::${aws_s3_bucket.finance.id}/*",
                "Principal": {
                    "AWS": [
                        "${data.aws_iam_user.finance-data.arn}"
                    ]
                }
            }
        ]
    }
EOF
}



