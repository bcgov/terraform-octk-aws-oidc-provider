# Download Github Certificate for AWS Identity provider
data "tls_certificate" "github" {
  url = var.github_tls_cert_url
}

# Github OIDC Configuration
resource "aws_iam_openid_connect_provider" "github" {
  url             = var.github_action_url
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]

  client_id_list = concat(
    ["sts.amazonaws.com"]
  )

  tags = var.tags
}

##############
## DyanmoDB ##
##############

# DynamoDB table for terraform lock
resource "aws_dynamodb_table" "lock" {
  name         = "terraform-remote-state-lock-${var.name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = false
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = var.tags
}

########
## S3 ##
########

# KMS Configuration for the encryption of the state file S3 bucket
resource "aws_kms_key" "this" {
  description             = var.kms_key_description
  deletion_window_in_days = var.kms_key_deletion_window_in_days
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.kms_key_alias}"
  target_key_id = aws_kms_key.this.key_id
}

# Forcing https for terraform state bucket
data "aws_iam_policy_document" "state_force_ssl" {
  statement {
    sid     = "AllowSSLRequestsOnly"
    actions = ["s3:*"]
    effect  = "Deny"
    resources = [
      aws_s3_bucket.state.arn,
      "${aws_s3_bucket.state.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

# Declaration of private ACL
resource "aws_s3_bucket_acl" "state" {
  bucket = aws_s3_bucket.state.id
  acl    = "private"
}

# Versionning is really important for terraform state file
resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Explicit deny of public access
resource "aws_s3_bucket_public_access_block" "state" {
  bucket                  = aws_s3_bucket.state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Bucket for Terraform state
resource "aws_s3_bucket" "state" {
  bucket        = "terraform-remote-state-${var.name}-${var.env}"
  acl           = "private"
  force_destroy = false

  tags = var.tags
}
