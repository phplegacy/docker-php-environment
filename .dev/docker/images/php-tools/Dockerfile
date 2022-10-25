# Dev environment image
# docker build --pull --tag php-tools --build-arg BUILDKIT_INLINE_CACHE=1 --file ./.dev/docker/images/php-tools/Dockerfile ./ && docker run -it --rm php-tools
FROM php:8.1-alpine

ENV TERM="xterm-256color" \
LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8" \
LC_TIME="en_DK.UTF-8" \
TIME_STYLE="long-iso"

# Core utilites install
RUN set -eux \
  && apk add --quiet --update --no-cache \
    bash \
    tzdata \
    mc \
    sudo \
    unzip \
    nano \
    iputils \
    git \
    ca-certificates \
    curl \
    ncurses \
    make \
    # `fcgi` - Healthcheck |  https://github.com/renatomefi/php-fpm-healthcheck
    fcgi \
    # `tini` - https://github.com/krallin/tini
    tini \
    # `figlet` is just for fun
    figlet

# Easily install PHP extension in Docker containers | https://github.com/mlocati/docker-php-extension-installer
RUN set -eux \
    && curl -fsSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions --output /usr/local/bin/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions \
    && IPE_GD_WITHOUTAVIF=1 install-php-extensions \
        @composer-2 \
        opcache \
        intl \
        bcmath \
        mcrypt \
        pcntl

RUN set -eux \
    #
    # Install Nano Syntax Highlighting
    && curl -fsSL https://github.com/scopatz/nanorc/archive/master.zip --output /tmp/nanorc.zip \
    && unzip -q /tmp/nanorc.zip -d /tmp/ && mkdir -p /usr/share/nano/ && mv /tmp/nanorc-master/*.nanorc /usr/share/nano/ \
    && echo 'include "/usr/share/nano/*.nanorc"' >> /etc/nanorc && rm -rf /tmp/nanorc-master/ /tmp/nanorc.zip

# set bash as a default shell
RUN set -eux \
    && echo "" > /root/.ash_history \
    && sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

# Making new local user
ARG APP_UID=1000
ARG APP_GID=1000
RUN set -eux \
    && addgroup -g $APP_GID user && adduser -D -G user -u $APP_UID user && chown user:user -R ./ \
    # Add user to sudoers, ONLY IN DEVELOPMENT ENVIRONMENT
    && echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user
# environment
ENV HOME /home/user
ENV PATH ${PATH}:${HOME}/.composer/vendor/bin:${HOME}/bin:/app/vendor/bin/

COPY --chown=user:user --chmod=0755 ./.dev/docker/etc/hello-msg.sh /etc/hello-msg.sh
COPY --chown=user:user ./.dev/docker/etc/.bashrc "${HOME}/.bashrc"
COPY ./.dev/docker/etc/.bashrc /root/.bashrc

RUN set -eux && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
COPY ./.dev/docker/config/php-tools/zzz-php_custom.ini /usr/local/etc/php/conf.d/zzz-php_custom.ini
COPY ./.dev/docker/config/composer/composer-allow-plugins.json /root/.composer/composer.json
COPY --chown=user:user ./.dev/docker/config/composer/composer-allow-plugins.json ${HOME}/.composer/composer.json

ARG TZ='UTC'
ENV TZ=$TZ

ENV CONTAINER_COPYRIGHT="github.com/phplegacy"
#Command bellow will be executed in motd via eval function, example: eval ${CONTAINER_HELLO_TEXT}
ENV CONTAINER_HELLO_TEXT="printf \"PHP Version: \${cGreen}\${PHP_VERSION}\${cNo}\n\""

# https://cs.symfony.com/doc/usage.html
ENV PHP_CS_FIXER_FUTURE_MODE=1

USER user

WORKDIR /app/

