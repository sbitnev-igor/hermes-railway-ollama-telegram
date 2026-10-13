# Hermes Agent on Railway — Telegram + Ollama Cloud

Deploy Hermes Agent as a persistent Telegram bot using Railway and Ollama Cloud.

## Features

- Hermes Agent running in Docker
- Telegram bot integration
- Ollama Cloud through an OpenAI-compatible API endpoint
- Persistent agent state using a Railway Volume
- Secrets configured outside Git

## 1. Create a Telegram bot

1. Open [@BotFather](https://t.me/BotFather).
2. Send `/newbot`.
3. Follow the prompts and copy the bot token.
4. Find your numeric Telegram user ID using [@userinfobot](https://t.me/userinfobot).

## 2. Get an Ollama Cloud API key

Open [Ollama](https://ollama.com/), obtain an API key, and confirm that your chosen model is available through the cloud API.

## 3. Deploy to Railway

1. Push these files to a GitHub repository.
2. In Railway, create a new project and deploy from that repository.
3. Add a **Volume** mounted at `/opt/data`.
4. Open the service's **Variables** tab and add:

| Variable | Value |
|---|---|
| `TELEGRAM_BOT_TOKEN` | Token from BotFather |
| `TELEGRAM_ALLOWED_USERS` | Your numeric Telegram user ID |
| `OLLAMA_API_KEY` | Your Ollama Cloud API key |
| `OLLAMA_MODEL` | `kimi-k2.5:cloud` or another supported model |
| `HERMES_HOME` | `/opt/data` |

5. Trigger a deployment.

This bot uses Telegram polling, so you do not need to expose a public HTTP port just to receive messages.

## 4. Test

1. Open the bot in Telegram.
2. Press **Start** and send a simple message.
3. Check Railway deployment logs if the bot does not respond.

## Security

- Never commit real API keys or bot tokens.
- Keep `TELEGRAM_ALLOWED_USERS` restricted to trusted numeric user IDs.
- Use Railway Variables for all secrets.
- Keep the `/opt/data` volume attached so configuration and agent state survive restarts.

## Troubleshooting

- **Bot does not start:** check `TELEGRAM_BOT_TOKEN` and service logs.
- **Access denied:** check `TELEGRAM_ALLOWED_USERS`.
- **LLM authentication error:** verify `OLLAMA_API_KEY`.
- **Model not found:** verify the model identifier available to your Ollama Cloud account.
- **Configuration disappears:** confirm the Railway Volume is mounted at `/opt/data`.

Official references:
- Hermes Telegram: https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/messaging/telegram.md
- Hermes custom providers: https://github.com/NousResearch/hermes-agent/blob/main/website/docs/integrations/providers.md
- Ollama Cloud: https://ollama.com/
- Railway: https://docs.railway.com/
