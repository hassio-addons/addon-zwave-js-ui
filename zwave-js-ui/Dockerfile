ARG BUILD_FROM=ghcr.io/hassio-addons/base:19.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Environment configuration
ENV \
    S6_KILL_GRACETIME=30000 \
    S6_SERVICES_GRACETIME=30000

# Setup base
ARG ZWAVE_JS_UI_VERSION="v11.8.2"
# hadolint ignore=DL3003,SC2046
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r3 \
        linux-headers=6.14.2-r0 \
        python3-dev=3.12.12-r0 \
    \
    && apk add --no-cache \
        eudev=3.2.14-r5 \
        libusb=1.0.28-r0 \
        nginx=1.28.0-r3 \
        nodejs=22.16.0-r2 \
        npm=11.6.4-r0 \
    \
    && curl -J -L -o /tmp/zwave-js-ui.tar.gz \
        "https://github.com/zwave-js/zwave-js-ui/archive/${ZWAVE_JS_UI_VERSION}.tar.gz" \
    && tar zxvf \
        /tmp/zwave-js-ui.tar.gz \
        --strip 1 -C /opt \
    \
    && cd /opt \
    && npm ci \
    && npm run build:server \
    && npm run build:ui \
    && npm rebuild --build-from-source @serialport/bindings-cpp \
    && npm prune --omit=dev \
    && npm cache clean --force \
    \
    && apk del --no-cache --purge .build-dependencies \
    && find /opt -mindepth 1 -maxdepth 1 \
        ! -name "node_modules" \
        ! -name "snippets" \
        ! -name "package.json" \
        ! -name "server" \
        ! -name "dist" \
        -exec rm -rf {} + \
    && rm -f -r \
        /etc/nginx \
        /root/.cache \
        /root/.config \
        /root/.npmrc \
        /root/.node-gyp \
        /root/.npm \
        /tmp/.[!.]* \
        /tmp/* \
        /usr/lib/node_modules \
        /usr/local/share/.cache

# Copy root filesystem
COPY rootfs /

# Health check
HEALTHCHECK CMD curl --fail http://127.0.0.1:8099/health/zwave || exit 1

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
