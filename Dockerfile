
FROM docker.io/nousresearch/hermes-agent:latest

USER root

# Update package index and install standard system utilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev \
        build-essential \
        pkg-config \
        git \
        curl \
        wget \
        ca-certificates \
        gnupg \
        jq \
        unzip \
        zip \
        procps \
        iproute2 \
        iputils-ping \
        openssh-client \
        ffmpeg \
        ripgrep \
        nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Keep the original Hermes entrypoint and s6 supervision
COPY --chmod=755 start.sh /usr/local/bin/railway-start.sh

CMD ["sh", "/usr/local/bin/railway-start.sh"]
