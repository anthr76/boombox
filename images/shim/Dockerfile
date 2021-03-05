FROM ghcr.io/anthr76/tumbleweed-dnf-toolbox

ENV NAME=anthr76-devops-toolbox
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      name="$NAME" \
      usage="This image is meant to be used with the toolbox command" \
      summary="You should not use this container and instead use your own customizations on a fork" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>"

RUN dnf install curl ansible cron zsh -y

RUN dnf clean all

RUN ansible-pull -U https://github.com/anthr76/tooling.git -i "$(uname -n)," -e playbook_dir shim/local.yml -t init

RUN curl https://artii.herokuapp.com/make?text=DevOps+Toolbox

CMD /bin/sh