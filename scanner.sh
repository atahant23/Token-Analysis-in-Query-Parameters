#!/bin/bash
# Atahan's URL Security Analyzer
# This script detects sensitive data exposure in URL query strings.

URL=$1

if [ -z "$URL" ]; then
    echo "Usage: ./scanner.sh <URL>"
    exit 1
fi

echo "--------------------------------------------------"
echo "🔍 ANALYZING URL: $URL"
echo "--------------------------------------------------"

# Check for sensitive keywords in the URL
if [[ "$URL" =~ "token=" ]] || [[ "$URL" =~ "session_token=" ]] || [[ "$URL" =~ "pass=" ]]; then
    echo -e "\033[0;31m[!] ALERT: SENSITIVE DATA EXPOSURE DETECTED (CWE-598)\033[0m"
    echo "Found: Sensitive parameters in the GET query string."
    echo "Risk: These values are logged in plaintext across proxies and browser history."
else
    echo -e "\033[0;32m[+] SUCCESS: No basic sensitive parameters found in URL.\033[0m"
fi
echo "--------------------------------------------------"
