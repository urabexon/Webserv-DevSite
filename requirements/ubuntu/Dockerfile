FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    vim \
    lsof \
    git \
    valgrind \
    php-cgi \
    php-cli \
    python3 \
    python3-pip \
    python3-venv \
    netcat-openbsd \
    curl \
    iproute2 \
    net-tools \
    procps \
    htop \
    strace \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
