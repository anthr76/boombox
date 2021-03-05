FROM registry.opensuse.org/opensuse/tumbleweed-dnf:latest

ENV NAME=tumbleweed-dnf-toolbox
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      name="$NAME" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Base image for creating OpenSUSE tumbleweed dnf toolbox containers" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>"

RUN sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf

COPY missing-docs /
RUN dnf -y reinstall $(<missing-docs)
RUN rm /missing-docs

COPY extra-packages /
RUN dnf -y install $(<extra-packages)
RUN rm /extra-packages

RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox

RUN dnf clean all

CMD /bin/sh