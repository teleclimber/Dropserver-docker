
ARG DS_HOST_VERSION

FROM buildpack-deps:20.04-curl AS download

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y tar \
  && rm -rf /var/lib/apt/lists/*

ARG DS_HOST_VERSION
RUN curl -fsSL https://github.com/teleclimber/dropserver/releases/download/v${DS_HOST_VERSION}/ds-host-amd64-linux.tar.gz \
    --output ds-host.tar.gz
RUN tar -xzf ds-host.tar.gz \
  && rm ds-host.tar.gz \
  && chmod 755 ds-host


FROM scratch

ARG DS_HOST_VERSION
ENV DS_HOST_VERSION=${DS_HOST_VERSION}

COPY --from=download /ds-host /ds-host