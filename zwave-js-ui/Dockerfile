ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
ARG ZWAVE_JS_UI_VERSION="v8.17.1"
# hadolint ignore=DL3003,SC2046
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r3 \
        linux-headers=6.3-r0 \
        npm=9.6.6-r0 \
        python3-dev=3.11.3-r11 \
    \
    && apk add --no-cache \
        eudev=3.2.11-r8 \
        libusb=1.0.26-r2 \
        nginx=1.24.0-r6 \
        nodejs=18.16.0-r1 \
    \
    && npm install --global yarn@2.4.3 \
    \
    && curl -J -L -o /tmp/zwave-js-ui.tar.gz \
        "https://github.com/zwave-js/zwave-js-ui/archive/${ZWAVE_JS_UI_VERSION}.tar.gz" \
    && tar zxvf \
        /tmp/zwave-js-ui.tar.gz \
        --strip 1 -C /opt \
    \
    && cd /opt \
    && yarn install --immutable \
    && yarn run build:server \
    && yarn run build:ui \
    && npm_config_build_from_source=true \
        yarn rebuild @serialport/bindings-cpp \
    && yarn remove \
        $(jq -r '.devDependencies | keys | join(" ")' package.json) \
    && yarn cache clean \
    \
    && npm uninstall -g yarn \
    && apk del --no-cache --purge .build-dependencies \
    && rm -f -r \
        /etc/nginx \
        /opt/build \
        /opt/index.html \
        /opt/package.sh \
        /opt/src \
        /opt/static \
        /opt/stylesheets \
        /opt/.[!.]* \
        /opt/*.md \
        /opt/nodemon.json \
        /opt/kustomization.yaml \
        /opt/kubernetes \
        /opt/docker \
        /opt/docs \
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
