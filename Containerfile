ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/core:${FREEBSD_RELEASE}

ARG PYVER
ARG NO_PKGCLEAN

LABEL org.opencontainers.image.title="Sopel" \
    org.opencontainers.image.description="Easy-to-use and highly extensible IRC Bot framework" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/sopel" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/sopel" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    umask 0022; \
    \
    pkg update; \
    pkg install -y py${PYVER}-sopel py${PYVER}-sopel-help; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*

VOLUME ["/usr/local/etc/sopel", "/var/log/sopel", "/var/db/sopel"]

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

COPY default.cfg /usr/local/etc/sopel

ENV SOPEL_CONFIG=default
ENV SOPEL_CONFIG_DIR=/usr/local/etc/sopel

CMD ["sopel", "start"]
