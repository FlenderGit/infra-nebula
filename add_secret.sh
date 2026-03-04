#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <secret_name> <secret_value>"
  exit 1
fi

SECRET_NAME=$1
SECRET_VALUE=$2

# Remove existing secret if it exists
if docker secret inspect "$SECRET_NAME" &>/dev/null; then
  echo "⚠️  Secret '$SECRET_NAME' already exists, removing it..."
  docker secret rm "$SECRET_NAME"
fi

# Create the secret
echo "$SECRET_VALUE" | docker secret create "$SECRET_NAME" -

echo "✅ Secret '$SECRET_NAME' created successfully"
