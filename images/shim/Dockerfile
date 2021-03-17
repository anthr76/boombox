FROM ghcr.io/anthr76/tumbleweed-dnf-toolbox

ENV NAME=anthr76-devops-toolbox
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      name="$NAME" \
      usage="This image is meant to be used with the toolbox command" \
      summary="You should not use this container and instead use your own customizations on a fork" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>"

RUN dnf update -y --refresh

RUN dnf install curl ansible zsh neovim -y

RUN dnf clean all

COPY 00-shim.sh /etc/profile.d/00-shim.sh

RUN mkdir /usr/libexec/toolbox
COPY host-runner /usr/libexec/toolbox/host-runner

RUN ls /usr/libexec/toolbox \
&& \
chmod +x /usr/libexec/toolbox/host-runner \
&& \
ln -s /usr/libexec/toolbox/host-runner /usr/libexec/flatpak \
&& \
ln -s /usr/libexec/toolbox/host-runner /usr/libexec/virsh \
&& \
ln -s /usr/libexec/toolbox/host-runner /usr/libexec/podman \
&& \
ln -s /usr/libexec/toolbox/host-runner /usr/libexec/virt-install

CMD /bin/sh