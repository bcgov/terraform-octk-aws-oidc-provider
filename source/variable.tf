#############
## General ##
#############

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
}

variable "name" {
  description = "License plate of the targeted account"
  type        = string
}

variable "env" {
  description = "environment of the targeted account"
  type        = string
}

variable "tags" {
  description = "List of tags"
  type        = map(string)

  default = {}
}

#################
## Github OIDC ##
#################

variable "github_tls_cert_url" {
  description = "URL to download the cert used by Github action (DOCS: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#:~:text=To%20see%20all%20the%20claims%20supported%20by%20GitHub%27s%20OIDC%20provider%2C%20review%20the%20claims_supported%20entries%20at%20https%3A//token.actions.githubusercontent.com/.well%2Dknown/openid%2Dconfiguration.)"
  type        = string

  default = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

variable "github_action_url" {
  description = "URL Used by Github action to send request (DOCS: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#:~:text=the%20OIDC%20token%3A-,https%3A//token.actions.githubusercontent.com,-sub)"
  type        = string

  default = "https://token.actions.githubusercontent.com"
}

################
## KMS Config ##
################

variable "kms_key_alias" {
  description = "The alias for the KMS key as viewed in AWS console. It will be automatically prefixed with `alias/`"
  type        = string

  default = "tf-remote-state-key"
}

variable "kms_key_description" {
  description = "The description of the key as viewed in AWS console."
  type        = string

  default = "This key is used to encrypt the S3 bucket used for the storage of terraform state file."
}

variable "kms_key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days."
  type        = number

  default = 30
}
