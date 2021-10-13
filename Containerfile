# static binary dependencies
FROM docker.io/alpine/helm:3.7.0 as helm
FROM docker.io/argoproj/argocli:v3.2.0 as argo-cli
FROM docker.io/aquasec/trivy:0.20.0 as trivy
FROM docker.io/bitnami/kubectl:1.22.2 as kubectl
FROM docker.io/cytopia/kubeval:0.16 as kubeval
FROM docker.io/fluxcd/flux-cli:v0.18.2 as flux
FROM docker.io/hadolint/hadolint:v2.7.0 as hadolint
FROM docker.io/jnorwood/helm-docs:v1.5.0 as helm-docs
FROM docker.io/kubesec/kubesec:v2.11.4 as kubesec
FROM docker.io/mikefarah/yq:4.13.4 as yq
FROM docker.io/minio/mc:RELEASE.2021-10-07T04-19-58Z as minio-mc
FROM docker.io/prom/alertmanager:v0.23.0 as prom-am
FROM docker.io/prom/prometheus:v2.30.3 as prom
FROM docker.io/zegl/kube-score:v1.12.0 as kube-score
FROM k8s.gcr.io/kustomize/kustomize:v4.4.0 as kustomize

# base image
FROM registry.fedoraproject.org/fedora:35@sha256:caf898842db03301682f9df2a3c5e163fa6b53e05c183eff593d136fe8a31dc0

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

WORKDIR /opt/toolbox

ENV PATH="$PATH:/opt/toolbox/node_modules/.bin"

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
ENV CHEZMOI_VERSION=v2.7.0
# renovate: datasource=github-releases depName=go-task/task
ENV GOTASK_VERSION=v3.9.0
# renovate: datasource=github-releases depName=mozilla/sops
ENV SOPS_VERSION=v3.7.1
# renovate: datasource=github-releases depName=hashicorp/terraform
ENV TERRAFORM_VERSION=v1.0.9
# renovate: datasource=github-releases depName=hashicorp/vault
ENV VAULT_VERSION=v1.8.4
COPY hack/hashicorp.repo /etc/yum.repos.d/hashicorp.repo
RUN \
  dnf install -y \
    acl \
    automake \
    awscli-1.20.31 \
    bash \
    bash-completion \
    bc \
    below \
    bzip2 \
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
    https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION#*v}-1.x86_64.rpm \
    https://github.com/go-task/task/releases/download/${GOTASK_VERSION}/task_linux_amd64.rpm \ 
  && dnf clean all -y \
  && rm -rf /var/cache/yum

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

CMD [ "/bin/sh" ]

ENV NAME=fedora-toolbox VERSION=35
LABEL org.opencontainers.image.source https://github.com/anthr76/boombox \
      com.github.containers.toolbox="true" \
      com.redhat.component="$NAME" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Fedora toolbox" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>, Devin Buhl <devin.kray@gmail.com>, Ryan Walter <rwalt@pm.me>"
