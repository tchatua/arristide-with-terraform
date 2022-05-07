resource "aws_iam_user" "admin-user" {
    name = "lucy"
    tags = {
        Description = "Technical Team Leader"
    }
}
resource "aws_iam_policy" "adminUser" {
    name = "AdminUser"
    policy = file("admin-policy.json")
}
resource "aws_iam_user_policy_attachment" "lucy_admin_access" {
  user = aws_iam_user.admin-user.name
  policy_arn = aws_iam_policy.adminUser.arn
}
