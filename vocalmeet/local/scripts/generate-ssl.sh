#!/bin/bash
# =============================================================================
# Generate Self-Signed SSL Certificate for Local Development
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SSL_DIR="${SCRIPT_DIR}/../ssl"
DOMAIN="vocalmeet.local"

mkdir -p "${SSL_DIR}"

echo "🔐 Generating self-signed SSL certificate for ${DOMAIN}..."

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "${SSL_DIR}/${DOMAIN}.key" \
    -out "${SSL_DIR}/${DOMAIN}.crt" \
    -subj "/C=VN/ST=Local/L=Local/O=Development/OU=Dev/CN=${DOMAIN}" \
    -addext "subjectAltName=DNS:${DOMAIN},DNS:localhost,IP:127.0.0.1"

if [ $? -eq 0 ]; then
    echo "✅ SSL certificate generated successfully!"
    echo "   - Certificate: ${SSL_DIR}/${DOMAIN}.crt"
    echo "   - Private Key: ${SSL_DIR}/${DOMAIN}.key"
    echo ""
    echo "⚠️  Note: Add ${DOMAIN} to your /etc/hosts file:"
    echo "   sudo sh -c 'echo \"127.0.0.1 ${DOMAIN}\" >> /etc/hosts'"
    echo ""
    echo "⚠️  You may need to trust this certificate in your browser."
    echo "   - Chrome: Go to chrome://flags/#allow-insecure-localhost and enable"
    echo "   - Or add the certificate to your system's trust store"
else
    echo "❌ Failed to generate SSL certificate"
    exit 1
fi
