FROM alpine:3.21.3

RUN apk update && \
	apk add --no-cache redis

# Uncomments and changes the bind address so Redis listens on all network interfaces
# (not just localhost).
# Enables a memory limit: Redis will only use up to 256 MB of RAM
# Redis will evict least recently used keys, from all keys, when memory is full.
# Suitable for caching scenarios.
RUN sed -i 's/^# bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf && \
	sed -i "s/^# maxmemory <bytes>/maxmemory 256mb/" /etc/redis.conf && \
	sed -i "s/^# maxmemory-policy noeviction/maxmemory-policy allkeys-lru"  /etc/redis.conf

# Redis' default port
EXPOSE 6379

# --protected-mode no: Disables Redis' protected mode, which is usually enabled
# to prevent remote access without a password. This is OK in development or
# isolated environments but not recommended for production without access controls.
ENTRYPOINT [ "redis-server", "--protected-mode", "no" ]
