<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.57.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.lock](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/dynamodb_table) | resource |
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_s3_bucket.state](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.state](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.state](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.state](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy_document.state_force_ssl](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.github](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for all resources. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | environment of the targeted account | `string` | n/a | yes |
| <a name="input_github_action_url"></a> [github\_action\_url](#input\_github\_action\_url) | URL Used by Github action to send request (DOCS: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#:~:text=the%20OIDC%20token%3A-,https%3A//token.actions.githubusercontent.com,-sub) | `string` | `"https://token.actions.githubusercontent.com"` | no |
| <a name="input_github_tls_cert_url"></a> [github\_tls\_cert\_url](#input\_github\_tls\_cert\_url) | URL to download the cert used by Github action (DOCS: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#:~:text=To%20see%20all%20the%20claims%20supported%20by%20GitHub%27s%20OIDC%20provider%2C%20review%20the%20claims_supported%20entries%20at%20https%3A//token.actions.githubusercontent.com/.well%2Dknown/openid%2Dconfiguration.) | `string` | `"https://token.actions.githubusercontent.com/.well-known/openid-configuration"` | no |
| <a name="input_kms_key_alias"></a> [kms\_key\_alias](#input\_kms\_key\_alias) | The alias for the KMS key as viewed in AWS console. It will be automatically prefixed with `alias/` | `string` | `"tf-remote-state-key"` | no |
| <a name="input_kms_key_deletion_window_in_days"></a> [kms\_key\_deletion\_window\_in\_days](#input\_kms\_key\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. | `number` | `30` | no |
| <a name="input_kms_key_description"></a> [kms\_key\_description](#input\_kms\_key\_description) | The description of the key as viewed in AWS console. | `string` | `"This key is used to encrypt the S3 bucket used for the storage of terraform state file."` | no |
| <a name="input_name"></a> [name](#input\_name) | License plate of the targeted account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_dynamodb_table_id"></a> [aws\_dynamodb\_table\_id](#output\_aws\_dynamodb\_table\_id) | Name of the S3 bucket storing terraform state |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | Name of the S3 bucket storing terraform state |
<!-- END_TF_DOCS -->