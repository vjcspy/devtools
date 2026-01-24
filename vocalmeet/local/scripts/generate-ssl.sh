#!/bin/bash
# =============================================================================
# Generate Self-Signed SSL Certificate for Local Development
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SSL_DIR="${SCRIPT_DIR}/../ssl"

mkdir -p "${SSL_DIR}"

echo "🔐 Generating self-signed SSL certificate for localhost..."

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "${SSL_DIR}/localhost.key" \
    -out "${SSL_DIR}/localhost.crt" \
    -subj "/C=VN/ST=Local/L=Local/O=Development/OU=Dev/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

if [ $? -eq 0 ]; then
    echo "✅ SSL certificate generated successfully!"
    echo "   - Certificate: ${SSL_DIR}/localhost.crt"
    echo "   - Private Key: ${SSL_DIR}/localhost.key"
    echo ""
    echo "⚠️  Note: You may need to trust this certificate in your browser."
    echo "   - Chrome: Go to chrome://flags/#allow-insecure-localhost and enable"
    echo "   - Or add the certificate to your system's trust store"
else
    echo "❌ Failed to generate SSL certificate"
    exit 1
fi
