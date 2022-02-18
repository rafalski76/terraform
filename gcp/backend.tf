# Using backend config in CLI will override this block
terraform {
  backend "gcs" {
    bucket = "szkola-chmury-bucket"
    prefix = "tf_state"
  }
}
