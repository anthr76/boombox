FROM ghcr.io/anthr76/tumbleweed-dnf-toolbox

ENV NAME=anthr76-devops-toolbox
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      name="$NAME" \
      usage="This image is meant to be used with the toolbox command" \
      summary="You should not use this container and instead use your own customizations on a fork" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>"

RUN dnf update -y --refresh --best --allowerasing

RUN dnf install curl ansible zsh neovim -y

RUN dnf clean all

COPY 00-shim.sh /etc/profile.d/00-shim.sh

RUN mkdir /usr/libexec/toolbox
COPY host-runner /usr/libexec/toolbox/host-runner
COPY toolbox-vscode/podman-host.sh /usr/libexec/toolbox/podman-host.sh
COPY toolbox-vscode/code.sh /usr/libexec/toolbox/code

RUN ls /usr/libexec/toolbox \
&& \
chmod +x /usr/libexec/toolbox/host-runner \
&& \
chmod +x /usr/libexec/toolbox/podman-host.sh \
&& \
chmod +x /usr/libexec/toolbox/code \
&& \
ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/flatpak \
&& \
ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/virsh \
&& \
ln -s /usr/libexec/toolbox/podman-host.sh /usr/libexec/toolbox/podman \
&& \
ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/virt-install

RUN rm -rf /root

RUN mkdir /root

RUN chmod -R 777 /root 

CMD /bin/sh