FROM nginx:latest

RUN apt-get update && \
    apt-get install -y \
    vim \
    && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
