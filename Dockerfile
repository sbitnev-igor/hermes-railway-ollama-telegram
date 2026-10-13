FROM nousresearch/hermes-agent:latest

COPY --chmod=755 start.sh /usr/local/bin/railway-start.sh

CMD ["sh", "/usr/local/bin/railway-start.sh"]
