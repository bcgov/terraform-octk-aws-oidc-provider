output "s3_bucket_name" {
    value = aws_s3_bucket.state.id
    description = "Name of the S3 bucket storing terraform state"
}

output "aws_dynamodb_table_id" {
    value = aws_dynamodb_table.lock.id
    description = "Name of the S3 bucket storing terraform state"
}
