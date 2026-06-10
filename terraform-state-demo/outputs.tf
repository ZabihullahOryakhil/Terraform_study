output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "bucket_region" {
  value = aws_s3_bucket.main.region
}

output "name_prefix" {
  value = local.name_prefix
}