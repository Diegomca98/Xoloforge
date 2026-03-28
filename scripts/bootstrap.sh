#!/bin/bash
set -euo pipefail

# ── Config ────────────────────────────────────────────────
AWS_REGION="${AWS_REGION:-us-east-1}"
BUCKET_NAME="${TF_STATE_BUCKET:-cv-platform-tfstate}"
DYNAMODB_TABLE="${TF_LOCK_TABLE:-cv-platform-tf-locks}"
# ─────────────────────────────────────────────────────────

echo "Bootstrapping Terraform backend..."
echo "  Region:   $AWS_REGION"
echo "  Bucket:   $BUCKET_NAME"
echo "  DynamoDB: $DYNAMODB_TABLE"

# ── S3 Bucket ─────────────────────────────────────────────
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "S3 bucket already exists, skipping."
else
  echo "Creating S3 bucket..."

  if [ "$AWS_REGION" = "us-east-1" ]; then
    aws s3api create-bucket \
      --bucket "$BUCKET_NAME" \
      --region "$AWS_REGION"
  else
    aws s3api create-bucket \
      --bucket "$BUCKET_NAME" \
      --region "$AWS_REGION" \
      --create-bucket-configuration LocationConstraint="$AWS_REGION"
  fi

  # Versioning — lets you recover a previous state if something goes wrong
  aws s3api put-bucket-versioning \
    --bucket "$BUCKET_NAME" \
    --versioning-configuration Status=Enabled

  # Encryption at rest
  aws s3api put-bucket-encryption \
    --bucket "$BUCKET_NAME" \
    --server-side-encryption-configuration '{
      "Rules": [{
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "AES256"
        }
      }]
    }'

  # Block all public access — state files must never be public
  aws s3api put-public-access-block \
    --bucket "$BUCKET_NAME" \
    --public-access-block-configuration \
      "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

  echo "S3 bucket created."
fi

# ── DynamoDB Table ────────────────────────────────────────
if aws dynamodb describe-table --table-name "$DYNAMODB_TABLE" --region "$AWS_REGION" 2>/dev/null; then
  echo "DynamoDB table already exists, skipping."
else
  echo "Creating DynamoDB table..."

  aws dynamodb create-table \
    --table-name "$DYNAMODB_TABLE" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region "$AWS_REGION"

  echo "DynamoDB table created."
fi

echo "Bootstrap complete."
