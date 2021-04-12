ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:9.1.7
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r2 \
        linux-headers=5.7.8-r0 \
        npm=14.16.1-r1 \
        python3-dev=3.8.8-r0 \
        yarn=1.22.10-r0 \
    \
    && apk add --no-cache \
        eudev=3.2.9-r3 \
        libusb=1.0.24-r1 \
        nginx=1.18.0-r13 \
        nodejs=14.16.1-r1 \
    \
    && curl -J -L -o /tmp/zwavejs2mqtt.tar.gz \
        "https://github.com/zwave-js/zwavejs2mqtt/archive/v3.2.0.tar.gz" \
    && tar zxvf \
        /tmp/zwavejs2mqtt.tar.gz \
        --strip 1 -C /opt \
    \
    && cd /opt \
    && npm config set unsafe-perm \
    && npm install \
    && npm run build \
    && npm prune --production \
    \
    && curl -J -L -o /tmp/zwavejs.tar.gz \
        "https://github.com/zwave-js/node-zwave-js/archive/68294d7406bf6603b058ffeab1c1dc4949a5a7d3.tar.gz" \
    && mkdir /tmp/zwavejs \
    && tar zxvf \
        /tmp/zwavejs.tar.gz \
        --strip 1 -C /tmp/zwavejs \
    \
    && rm -f -r /opt/node_modules/@zwave-js/config/config/devices/* \
    && mv /tmp/zwavejs/packages/config/config/devices/* /opt/node_modules/@zwave-js/config/config/devices/ \
    \
    && apk del --no-cache --purge .build-dependencies \
    \
    && rm -f -r \
        /etc/nginx \
        /opt/build \
        /opt/index.html \
        /opt/package-lock.json \
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
