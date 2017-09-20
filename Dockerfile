FROM alpine:3.6

# Install dependencies
RUN apk update && \
    apk add --no-cache ca-certificates dumb-init openssl && \
    update-ca-certificates

# Setup kubectl
RUN \
  wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.7.5/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl

COPY crontab /var/spool/cron/crontabs/root
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD crond -l 2 -f
