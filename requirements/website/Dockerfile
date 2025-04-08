FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r www-data || true && \
    useradd -r -g www-data www-data || true

COPY ./website/create_test_site.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_test_site.sh

CMD ["/usr/local/bin/create_test_site.sh"]
