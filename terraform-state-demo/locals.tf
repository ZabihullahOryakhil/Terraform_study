locals {
  name_prefix = "${var.project}-${var.environment}"

  versioning_status = var.bucket_versioning ? "Enabled" : "Suspended"

  is_prod = var.environment == "prod"
}