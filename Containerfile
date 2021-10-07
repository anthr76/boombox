# dependencies
FROM docker.io/alpine/helm:3.7.0 as helm
FROM docker.io/argoproj/argocli:v3.1.13 as argo-cli
FROM docker.io/aquasec/trivy:0.20.0 as trivy
FROM docker.io/bitnami/kubectl:1.22.2 as kubectl
FROM docker.io/cytopia/kubeval:0.16 as kubeval
FROM docker.io/fluxcd/flux-cli:v0.17.2 as flux
FROM docker.io/hadolint/hadolint:v2.7.0 as hadolint
FROM docker.io/hashicorp/terraform:1.0.8 as terraform
FROM docker.io/jnorwood/helm-docs:v1.5.0 as helm-docs
FROM docker.io/koalaman/shellcheck:v0.7.2 as shellcheck
FROM docker.io/kubesec/kubesec:v2.11.4 as kubesec
FROM docker.io/mikefarah/yq:4.13.3 as yq
FROM docker.io/prom/alertmanager:v0.23.0 as prom-am
FROM docker.io/prom/prometheus:v2.30.3 as prom
FROM docker.io/zegl/kube-score:v1.12.0 as kube-score
FROM k8s.gcr.io/kustomize/kustomize:v4.4.0 as kustomize

# base image
FROM registry.fedoraproject.org/fedora:35@sha256:b7bb22ac74a4cdad8fa64341cb2f665a5ca9301b526437fb62013457fea605b2

WORKDIR /opt/toolbox

ENV GOPATH="/opt/toolbox/go"
ENV PATH="$PATH:/opt/toolbox/node_modules/.bin:${GOPATH}/bin"

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

# renovate: datasource=repology depName=fedora_35
ENV FISH_VERSION=3.3.1
# renovate: datasource=repology depName=fedora_35
ENV GO_VERSION=1.16.8
# renovate: datasource=repology depName=fedora_35
ENV NODE_VERSION=16.10.0
# renovate: datasource=repology depName=fedora_35
ENV NPM_VERSION=7.24.0

RUN \
  dnf install -y \
    acl \
    automake \
    bash \
    bash-completion \
    bc \
    below \
    bzip2 \
    ca-certificates \
    curl \
    diffutils \
    dos2unix \
    dnf-plugins-core \
    findutils \
    fish-${FISH_VERSION} \
    flatpak-spawn \
    fpaste \
    gawk \
    git \
    gnupg \
    gnupg2-smime \
    golang-${GO_VERSION} \
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
    lsof \
    man-db \
    man-pages \
    mlocate \
    mtr \
    nano-default-editor \
    neovim \
    nodejs-${NODE_VERSION} \
    npm-${NPM_VERSION} \
    nss-mdns \
    openssl \
    openssh-clients \
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
    python-setuptools \
    python-six \
    rpm \
    rsync \
    sed \
    shadow-utils \
    sudo \
    systemd \
    tar \
    tcpdump \
    time \
    tmate \
    tmux \
    traceroute \
    tree \
    unzip \
    vte-profile \
    wget \
    which \
    words \
    xorg-x11-xauth \
    xz \
    zip

# golang
RUN \
  go install github.com/drone/envsubst/cmd/envsubst@latest \
  && envsubst --version

# nodejs
COPY package*.json .
RUN \
  npm ci --only=production \
  && markdownlint --version \
  && prettier --version

# python
COPY requirements.txt .
RUN \
  pip install --no-cache-dir -r requirements.txt \
  && \
  aws --version \
  && yamllint --version \
  && ansible --version

# github releases
COPY hack/github-releases.sh /opt/toolbox/github-releases.sh
RUN /opt/toolbox/github-releases.sh

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
COPY --from=prom       /bin/promtool                    /usr/local/bin/promtool
COPY --from=prom-am    /bin/amtool                      /usr/local/bin/amtool
COPY --from=shellcheck /bin/shellcheck                  /usr/local/bin/shellcheck
COPY --from=terraform  /bin/terraform                   /usr/local/bin/terraform
COPY --from=trivy      /usr/local/bin/trivy             /usr/local/bin/trivy
COPY --from=yq         /usr/bin/yq                      /usr/local/bin/yq

CMD [ "/bin/sh" ]

ENV NAME=fedora-toolbox VERSION=35
LABEL org.opencontainers.image.source https://github.com/anthr76/boombox \
      com.github.containers.toolbox="true" \
      com.redhat.component="$NAME" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Fedora toolbox" \
      maintainer="Anthony Rabbito <hello@anthonyrabbito.com>, Devin Buhl <devin.kray@gmail.com>"
