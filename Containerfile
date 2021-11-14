# static binary dependencies
FROM docker.io/alpine/helm:3.7.1 as helm
FROM docker.io/argoproj/argocli:v3.2.3 as argo-cli
FROM docker.io/aquasec/trivy:0.20.2 as trivy
FROM docker.io/bitnami/kubectl:1.22.3 as kubectl
FROM docker.io/cytopia/kubeval:0.16 as kubeval
FROM docker.io/fluxcd/flux-cli:v0.20.0 as flux
FROM docker.io/hadolint/hadolint:v2.8.0 as hadolint
FROM docker.io/jnorwood/helm-docs:v1.5.0 as helm-docs
FROM docker.io/kubesec/kubesec:v2.11.4 as kubesec
FROM docker.io/mikefarah/yq:4.14.2 as yq
FROM docker.io/minio/mc:RELEASE.2021-10-07T04-19-58Z as minio-mc
FROM docker.io/prom/alertmanager:v0.23.0 as prom-am
FROM docker.io/prom/prometheus:v2.31.1 as prom
FROM docker.io/zegl/kube-score:v1.13.0 as kube-score
FROM docker.io/drwetter/testssl.sh:3.0 as testssl
FROM docker.io/amazon/aws-cli:2.3.2 as awscli
FROM k8s.gcr.io/kustomize/kustomize:v4.4.1 as kustomize

# base image (skopeo inspect  --format "Name: {{.Name}} Digest: {{.Digest}}" docker://registry.fedoraproject.org/fedora:35)
FROM registry.fedoraproject.org/fedora@sha256:b6f50408eea9177696c55d3db523f0bacbbed8d3d294f4b12566f24ec7a3078c

# copy binaries from static binary dependencies
COPY --from=argo-cli   /bin/argo                        /usr/local/bin/argo
COPY --from=flux       /usr/local/bin/flux              /usr/local/bin/flux
COPY --from=hadolint   /bin/hadolint                    /usr/local/bin/hadolint
COPY --from=helm       /usr/bin/helm                    /usr/local/bin/helm
COPY --from=helm-docs  /usr/bin/helm-docs               /usr/local/bin/helm-docs
COPY --from=kube-score /kube-score                      /usr/local/bin/kube-score
COPY --from=kubectl    /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
COPY --from=kubesec    /bin/kubesec                     /usr/local/bin/kubesec
COPY --from=kubeval    /usr/bin/kubeval                 /usr/local/bin/kubeval
COPY --from=kustomize  /app/kustomize                   /usr/local/bin/kustomize
COPY --from=minio-mc   /usr/bin/mc                      /usr/local/bin/mc
COPY --from=prom       /bin/promtool                    /usr/local/bin/promtool
COPY --from=prom-am    /bin/amtool                      /usr/local/bin/amtool
COPY --from=trivy      /usr/local/bin/trivy             /usr/local/bin/trivy
COPY --from=yq         /usr/bin/yq                      /usr/local/bin/yq
COPY --from=testssl    /home/testssl/                   /usr/local/bin/testssl/
COPY --from=awscli     /usr/local/aws-cli/              /usr/local/aws-cli/
COPY --from=awscli     /usr/local/bin/                  /usr/local/bin/

WORKDIR /opt/toolbox

ENV PATH="$PATH:/opt/toolbox/node_modules/.bin:/usr/local/bin/testssl/" \
    TESTSSL_INSTALL_DIR="/usr/local/bin/testssl/" \
    LANG=en_US.UTF-8

RUN \
  sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf \
  && echo "installonly_limit=15" | tee -a /etc/dnf/dnf.conf \
  && echo "max_parallel_downloads=20" | tee -a /etc/dnf/dnf.conf

COPY hack/host-runner /usr/libexec/toolbox/host-runner
COPY hack/podman-host.sh /usr/libexec/toolbox/podman-host.sh
COPY hack/01-shim.sh /etc/profile.d/01-shim.sh
RUN \
  ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/flatpak \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/virsh \
  && ln -s /usr/libexec/toolbox/podman-host.sh /usr/libexec/toolbox/podman \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/skopeo \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/buildah \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/virt-install \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/ostree \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/toolbox/rpm-ostree

# renovate: datasource=github-releases depName=twpayne/chezmoi
ENV CHEZMOI_VERSION=v2.7.5
# renovate: datasource=github-releases depName=go-task/task
ENV GOTASK_VERSION=v3.9.0
# renovate: datasource=github-releases depName=cli/cli
ENV GH_VERSION=v2.2.0
# renovate: datasource=github-releases depName=mozilla/sops
ENV SOPS_VERSION=v3.7.1
# renovate: datasource=github-releases depName=hashicorp/terraform
ENV TERRAFORM_VERSION=v1.0.11
# renovate: datasource=github-releases depName=hashicorp/vault
ENV VAULT_VERSION=v1.8.5
COPY hack/hashicorp.repo /etc/yum.repos.d/hashicorp.repo
RUN \
  dnf install -y \
    acl \
    automake \
    bash \
    bash-completion \
    bc \
    below \
    bzip2 \
    bind-utils \
    ca-certificates \
    curl \
    diffutils \
    direnv-2.28.0 \
    dnf-plugins-core \
    dos2unix \
    findutils \
    fish-3.3.1 \
    flatpak-spawn \
    fpaste \
    fzf \
    gawk \
    git \
    glibc-locale-source \
    glibc-langpack-en \
    gnupg \
    gnupg2-smime \
    golang-1.16.8 \
    grep \
    gvfs-client \
    gzip \
    hostname \
    iproute \
    iputils \
    jwhois \
    keyutils \
    krb5-libs \
    less \
    libcap \
    libffi-devel \
    lsd \
    lsof \
    man-db \
    man-pages \
    mlocate \
    mtr \
    nano-default-editor \
    neovim \
    nodejs-16.10.0 \
    npm-7.24.0 \
    nss-mdns \
    openssh-clients \
    openssl \
    openssl-devel \
    p11-kit \
    pam \
    passwd \
    pigz \
    pinentry \
    procps-ng \
    python \
    python-devel \
    python-pip \
    python-six \
    ripgrep \
    rpm \
    rsync \
    sed \
    shadow-utils \
    ShellCheck \
    sudo \
    systemd \
    tar \
    tcpdump \
    thefuck \ 
    pre-commit \
    terraform-${TERRAFORM_VERSION#*v} \
    time \
    tmate \
    tmux \
    traceroute \
    tree \
    unzip \
    vte-profile \
    wget \
    which \
    wl-clipboard \
    words \
    xorg-x11-xauth \
    xz \
    yamllint \
    vault-${VAULT_VERSION#*v} \
    zip \
    https://github.com/twpayne/chezmoi/releases/download/${CHEZMOI_VERSION}/chezmoi-${CHEZMOI_VERSION#*v}-x86_64.rpm \
    https://github.com/cli/cli/releases/download/${GH_VERSION}/gh_${GH_VERSION#*v}_linux_amd64.rpm \
    https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION#*v}-1.x86_64.rpm \
    https://github.com/go-task/task/releases/download/${GOTASK_VERSION}/task_linux_amd64.rpm \
  && dnf clean all -y \
  && rm -rf /var/cache/yum \
  && localedef --verbose --force -i en_US -f UTF-8 en_US.UTF-8 || true

# golang
RUN \
  export GOPATH=/opt/toolbox/go \
  && go install github.com/drone/envsubst/cmd/envsubst@latest \
    && mv /opt/toolbox/go/bin/envsubst /usr/local/bin/envsubst \
    && envsubst --version

# nodejs
COPY package*.json .
RUN \
  npm install --only=production \
  && bw --version \
  && markdownlint --version \
  && prettier --version

# python
COPY requirements.txt .
RUN \
  pip install --no-cache-dir -r requirements.txt \
  && ansible --version

# github releases
COPY hack/github-releases.sh /opt/toolbox/github-releases.sh
RUN /opt/toolbox/github-releases.sh

# Add autocompletion
COPY hack/go-autocompletion.sh /tmp/go-autocompletion.sh
RUN sh /tmp/go-autocompletion.sh

CMD [ "/bin/sh" ]

ENV NAME=fedora-toolbox VERSION=35
LABEL org.opencontainers.image.source https://github.com/anthr76/boombox \
      com.github.containers.toolbox="true" \
      com.redhat.component="$NAME" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Fedora toolbox" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>, Devin Buhl <devin.kray@gmail.com>, Ryan Walter <rwalt@pm.me>, Stefan Crain <stefancrain@gmail.com>"
