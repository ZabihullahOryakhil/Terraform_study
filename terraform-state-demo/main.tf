resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "main" {
  bucket = "${local.name_prefix}-${random_id.suffix.hex}"

  force_destroy = local.is_prod ? false : true

  tags = {
    Name = "${local.name_prefix}-bucket"
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = local.versioning_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }

    bucket_key_enabled = true
  }
}


resource "aws_s3_bucket_public_access_block" "main" {
    bucket = aws_s3_bucket.main.id
    
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}


# Lifecycle rule - auto deleting old versions

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  depends_on = [ aws_s3_bucket_versioning.main ]

  rule {
    id = "expire-old-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
        noncurrent_days = var.noncurrent_expiry_days
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}