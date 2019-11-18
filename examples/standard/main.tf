provider "aws" {
  version    = "~> 2"
  region     = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
}

module "standard" {
  source = "../../"

  name = "tftest${random_string.this.result}"

  kms_key_create       = true
  kms_key_name         = "tftestS3KmsKey${random_string.this.result}"
  kms_key_alias_name   = "tftestS3KeySsm${random_string.this.result}"
  iam_policy_create    = true
  iam_policy_read_name = "tftestPolicyReadS3${random_string.this.result}"
  iam_policy_full_name = "tftestPolicyFullS3${random_string.this.result}"

  tags {
    testTag = "tftest"
  }
}
