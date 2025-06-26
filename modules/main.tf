resource "aws_s3_bucket" "terraform_basics" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_notification" "terraform_basics" {
  bucket = aws_s3_bucket.terraform_basics.id
  eventbridge = true
}

#Create an EventBridge Rule
resource "aws_cloudwatch_event_rule" "terraform_basics" {
  name = "terraform-basics-eventbridge-rule"
  description = "Match 'Object Created' events from the specified S3 bucket."
  event_pattern = jsonencode({
    source = ["aws.s3"]
    detail-type = ["Object Created"]
    detail = {
      bucket = {
        name = [var.bucket_name]
      }
    }
  })
}