#FROM debian:bookworm-slim

# Install necessary dependencies
#RUN apt-get update && \
#    apt-get install -y curl sudo bash && \
#    rm -rf /var/lib/apt/lists/*

# Install Netdata with the official script
#RUN curl -s https://my-netdata.io/kickstart.sh > /tmp/netdata-kickstart.sh && \
#    bash /tmp/netdata-kickstart.sh --dont-wait --disable-telemetry && \
#    rm /tmp/netdata-kickstart.sh

# Expose Netdata's default port
#EXPOSE 19999

# Run Netdata in the foreground
#ENTRYPOINT ["/opt/netdata/bin/netdata", "-D"]


#version 2
FROM netdata/netdata:stable

EXPOSE 19999


#You can create a new Agent container with docker run or docker-compose, then access
# the dashboard at http://NODE:19999.
