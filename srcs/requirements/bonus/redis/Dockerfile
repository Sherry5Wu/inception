FROM alpine:3.21.3

RUN apk update && \
    apk add --no-cache redis

# Configure Redis to:
# - Listen on all interfaces
# - Limit memory to 256MB
# - Use allkeys-lru eviction policy
# - (Optional) Require password for security

RUN sed -i 's/^# bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf && \
    sed -i "s/^# maxmemory <bytes>/maxmemory 256mb/" /etc/redis.conf && \
    sed -i "s/^# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/" /etc/redis.conf && \
    echo "dir /data" >> /etc/redis.conf

EXPOSE 6379

# ENTRYPOINT [ "redis-server", "/etc/redis.conf", "--protected-mode", "no" ]
