#!/usr/bin/env bash

set -eux

# renovate: datasource=github-releases depName=projectcalico/calicoctl
export CALICOCTL_VERSION=v3.21.0
curl -fsSL -o /usr/local/bin/calicoctl \
    "https://github.com/projectcalico/calicoctl/releases/download/${CALICOCTL_VERSION}/calicoctl-linux-amd64"
chmod +x /usr/local/bin/calicoctl
test -x /usr/local/bin/calicoctl 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=schollz/croc
export CROC_VERSION=v9.4.2
curl -fsSL "https://github.com/schollz/croc/releases/download/${CROC_VERSION}/croc_${CROC_VERSION#*v}_Linux-64bit.tar.gz" \
    | tar xvz -f - -C /tmp
mv /tmp/croc /usr/local/bin/croc
test -x /usr/local/bin/croc 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=sbstp/kubie
export KUBIE_VERSION=v0.15.1
curl -fsSL -o /usr/local/bin/kubie \
    "https://github.com/sbstp/kubie/releases/download/${KUBIE_VERSION}/kubie-linux-amd64"
chmod +x /usr/local/bin/kubie
test -x /usr/local/bin/kubie 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=mvdan/sh
export SHFMT_VERSION=v3.4.0
curl -fsSL -o /usr/local/bin/shfmt \
    "https://github.com/mvdan/sh/releases/download/${SHFMT_VERSION}/shfmt_${SHFMT_VERSION}_linux_amd64"
chmod +x /usr/local/bin/shfmt
test -x /usr/local/bin/shfmt 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=starship/starship
export STARSHIP_VERSION=v1.0.0
curl -fsSL "https://github.com/starship/starship/releases/download/${STARSHIP_VERSION}/starship-x86_64-unknown-linux-gnu.tar.gz" \
    | tar xvz -f - -C /tmp
mv /tmp/starship /usr/local/bin/starship
test -x /usr/local/bin/starship 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=stern/stern
export STERN_VERSION=v1.21.0
curl -fsSL "https://github.com/stern/stern/releases/download/${STERN_VERSION}/stern_${STERN_VERSION#*v}_linux_amd64.tar.gz" \
    | tar xvz -f - --strip-components=1 -C /tmp
mv /tmp/stern /usr/local/bin/stern
test -x /usr/local/bin/stern 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=vmware-tanzu/velero
export VELERO_VERSION=v1.7.0
curl -fsSL "https://github.com/vmware-tanzu/velero/releases/download/${VELERO_VERSION}/velero-${VELERO_VERSION}-linux-amd64.tar.gz" \
    | tar xvz -f - --strip-components=1 -C /tmp
mv /tmp/velero /usr/local/bin/velero
test -x /usr/local/bin/velero 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=sachaos/viddy
export VIDDY_VERSION=v0.3.3
curl -fsSL "https://github.com/sachaos/viddy/releases/download/${VIDDY_VERSION}/viddy_${VIDDY_VERSION#*v}_Linux_x86_64.tar.gz" \
    | tar xvz -f - -C /tmp
mv /tmp/viddy /usr/local/bin/viddy
test -x /usr/local/bin/viddy 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=talos-systems/talos
export TALOSCTL_VERSION=v0.13.2
curl -fsSL -o /usr/local/bin/talosctl \
    "https://github.com/talos-systems/talos/releases/download/${TALOSCTL_VERSION}/talosctl-linux-amd64"
chmod +x /usr/local/bin/talosctl
test -x /usr/local/bin/talosctl 2>&1 || exit 1

# renovate: datasource=github-releases depName=kubernetes-sigs/cluster-api
export CLUSTERCTL_VERSION=v0.4.4
curl -fsSL -o /usr/local/bin/clusterctl \
    "https://github.com/kubernetes-sigs/cluster-api/releases/download/${CLUSTERCTL_VERSION}/clusterctl-linux-amd64"
chmod +x /usr/local/bin/clusterctl
test -x /usr/local/bin/clusterctl 2>&1 || exit 1

# renovate: datasource=github-releases depName=cilium/cilium-cli
export CILIUMCLI_VERSION=v0.9.3
curl -fsSL "https://github.com/cilium/cilium-cli/releases/download/${CILIUMCLI_VERSION}/cilium-linux-amd64.tar.gz" \
    | tar xvz -f - -C /tmp
mv /tmp/cilium /usr/local/bin/cilium
test -x /usr/local/bin/cilium 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=itchyny/gojq
export GOJQ_VERSION=v0.12.5
curl -fsSL "https://github.com/itchyny/gojq/releases/download/${GOJQ_VERSION}/gojq_${GOJQ_VERSION}_linux_amd64.tar.gz" \
    | tar xvz -f - --strip-components=1 -C /tmp
mv /tmp/gojq /usr/local/bin/gojq
test -x /usr/local/bin/gojq 2>&1 || exit 1
rm -rf /tmp/*

# renovate: datasource=github-releases depName=ogham/dog
export DOG_VERSION=v0.1.0
curl -fsSL -o /tmp/dog.zip "https://github.com/ogham/dog/releases/download/${DOG_VERSION}/dog-${DOG_VERSION}-x86_64-unknown-linux-gnu.zip"
unzip -j -o -d /tmp /tmp/dog.zip
mv /tmp/dog /usr/local/bin/dog
chmod +x /usr/local/bin/dog
test -x /usr/local/bin/dog 2>&1 || exit 1
rm -rf /tmp/*
