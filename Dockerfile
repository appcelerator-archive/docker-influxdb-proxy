FROM haproxy:1.6-alpine
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
EXPOSE 8083 8086
