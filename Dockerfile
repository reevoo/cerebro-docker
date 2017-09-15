FROM alpine:3.6

ENV CEREBRO_VERSION=0.6.6 \
    CEREBRO_CHECKSUM=366c032f87c62995713f8f07cc93caf5238f367bda203593af51635efde33bb43bc69fcfd0e91f52dc296d70695ee586cd839bf03442705f5df94d59acff9d60

WORKDIR /opt/cerebro
RUN set -ex;\
  addgroup -S cerebro && adduser -S -G cerebro cerebro; \
  apk add --no-cache \
    bash \
    ca-certificates \
    openjdk8-jre \
    wget \
  ; \
  wget --no-verbose -O cerebro.tgz https://github.com/lmenezes/cerebro/releases/download/v$CEREBRO_VERSION/cerebro-$CEREBRO_VERSION.tgz; \
  sha512sum cerebro.tgz; \
  echo "$CEREBRO_CHECKSUM *cerebro.tgz" | sha512sum -c -; \
  tar -xf cerebro.tgz --strip-components=1; \
  rm cerebro.tgz; \
  apk del --no-cache wget; \
  chown -R cerebro:cerebro /opt/cerebro;

USER cerebro
EXPOSE 9000
ENTRYPOINT /opt/cerebro/bin/cerebro
