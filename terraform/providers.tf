provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Project   = "aws-high-availability-webapp"
      ManagedBy = "terraform"
      Owner     = "agent077"
    }
  }
}
