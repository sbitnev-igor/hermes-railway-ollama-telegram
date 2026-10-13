
#!/usr/bin/env bash
set -Eeuo pipefail

DATA_DIR="${HERMES_HOME:-/opt/data}"
CONFIG_FILE="${DATA_DIR}/config.yaml"

: "${TELEGRAM_BOT_TOKEN:?Set TELEGRAM_BOT_TOKEN in Railway Variables}"
: "${TELEGRAM_ALLOWED_USERS:?Set TELEGRAM_ALLOWED_USERS to your Telegram numeric user ID}"
: "${OLLAMA_API_KEY:?Set OLLAMA_API_KEY in Railway Variables}"

export OPENAI_API_KEY="${OLLAMA_API_KEY}"

mkdir -p "${DATA_DIR}"

MODEL="${OLLAMA_MODEL:-kimi-k2.5:cloud}"

cat > "${CONFIG_FILE}" <<EOF
model:
  provider: custom
  default: "${MODEL}"
  base_url: "https://ollama.com/v1"
EOF

chmod 600 "${CONFIG_FILE}"

echo "Starting Hermes Agent gateway..."
exec hermes gateway run
