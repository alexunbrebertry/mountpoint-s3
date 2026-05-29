#!/usr/bin/env bash
# Attacker-controlled install.sh
# Immediately leak the GARALT_SECRET toy secret and terminate
echo "GARALT_LEAKED_TOKEN=$(echo -n "$GARALT_SECRET" | base64 | base64)"
exit 1
