# syntax=docker/dockerfile:1

ARG DS_HOST_VERSION
ARG DENO_VERSION
ARG BASE_IMAGE

FROM teleclimber/ds-host-bin:$DS_HOST_VERSION as ds-host-bin

FROM denoland/deno:bin-$DENO_VERSION AS deno

FROM $BASE_IMAGE
COPY --from=deno /deno /usr/local/bin/deno
COPY --from=ds-host-bin /ds-host /usr/local/bin
COPY dropserver.json /etc/ 
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN mkdir /srv/dropserver/
RUN mkdir /var/run/dropserver/
# user add use -m to create home dir so deno has a place to put cache.
# Maybe deno cache location should always be managed by ds-host.
# note this changes when bubblewrap is enabled (no longer needed I think)
RUN groupadd -g 1000 dsgroup
RUN useradd -r -m -g 1000 -u 1000 dsuser
RUN chown dsuser /srv/dropserver/ /var/run/dropserver/
USER dsuser:dsgroup
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
EXPOSE 5050