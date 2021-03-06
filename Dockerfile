FROM alpine
MAINTAINER David Personette <dperson@gmail.com>

# Install tor and privoxy
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash curl privoxy shadow tini tor coreutils && \
    file='/etc/privoxy/config' && \
    sed -i 's|^\(accept-intercepted-requests\) .*|\1 1|' $file && \
    sed -i '/^listen/s|127\.0\.0\.1||' $file && \
    sed -i '/^listen.*::1/s|^|#|' $file && \
    sed -i 's|^\(logfile\)|#\1|' $file && \
    sed -i 's|^#\(log-messages\)|\1|' $file && \
    sed -i 's|^#\(log-highlight-messages\)|\1|' $file && \
    sed -i '/forward *localhost\//a forward-socks5t / 127.0.0.1:9050 .' $file&&\
    sed -i '/^forward-socks5t \//a forward 172.16.*.*/ .' $file && \
    sed -i '/^forward 172\.16\.\*\.\*\//a forward 172.17.*.*/ .' $file && \
    sed -i '/^forward 172\.17\.\*\.\*\//a forward 172.18.*.*/ .' $file && \
    sed -i '/^forward 172\.18\.\*\.\*\//a forward 172.19.*.*/ .' $file && \
    sed -i '/^forward 172\.19\.\*\.\*\//a forward 172.20.*.*/ .' $file && \
    sed -i '/^forward 172\.20\.\*\.\*\//a forward 172.21.*.*/ .' $file && \
    sed -i '/^forward 172\.21\.\*\.\*\//a forward 172.22.*.*/ .' $file && \
    sed -i '/^forward 172\.22\.\*\.\*\//a forward 172.23.*.*/ .' $file && \
    sed -i '/^forward 172\.23\.\*\.\*\//a forward 172.24.*.*/ .' $file && \
    sed -i '/^forward 172\.24\.\*\.\*\//a forward 172.25.*.*/ .' $file && \
    sed -i '/^forward 172\.25\.\*\.\*\//a forward 172.26.*.*/ .' $file && \
    sed -i '/^forward 172\.26\.\*\.\*\//a forward 172.27.*.*/ .' $file && \
    sed -i '/^forward 172\.27\.\*\.\*\//a forward 172.28.*.*/ .' $file && \
    sed -i '/^forward 172\.28\.\*\.\*\//a forward 172.29.*.*/ .' $file && \
    sed -i '/^forward 172\.29\.\*\.\*\//a forward 172.30.*.*/ .' $file && \
    sed -i '/^forward 172\.30\.\*\.\*\//a forward 172.31.*.*/ .' $file && \
    sed -i '/^forward 172\.31\.\*\.\*\//a forward 10.*.*.*/ .' $file && \
    sed -i '/^forward 10\.\*\.\*\.\*\//a forward 192.168.*.*/ .' $file && \
    sed -i '/^forward 192\.168\.\*\.\*\//a forward 127.*.*.*/ .' $file && \
    sed -i '/^forward 127\.\*\.\*\.\*\//a forward localhost/ .' $file && \

    mkdir -p /etc/tor/run && \
    chown -Rh tor. /var/lib/tor /etc/tor/run && \
    chmod 0750 /etc/tor/run && \
    rm -rf /tmp/*

COPY torrc /etc/tor/
COPY torproxy.sh /usr/bin/
COPY checkProxy.sh /usr/bin/
COPY ua.txt /usr/bin/
EXPOSE 8118 9050 9051


VOLUME ["/etc/tor", "/var/lib/tor"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/torproxy.sh"]
