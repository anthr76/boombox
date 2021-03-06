FROM ghcr.io/anthr76/tumbleweed-dnf-toolbox

ENV NAME=anthr76-devops-toolbox
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      name="$NAME" \
      usage="This image is meant to be used with the toolbox command" \
      summary="You should not use this container and instead use your own customizations on a fork" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>"

RUN dnf install curl ansible zsh neovim -y

RUN dnf clean all

COPY 00-shim.sh /etc/profile.d/00-shim.sh

CMD /bin/sh