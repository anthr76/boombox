#!/bin/sh
echo "Bash Autocompletion"
BASHDIR="/etc/bash_completion.d/boombox"
{
helm completion bash
flux completion bash 
talosctl completion bash 
clusterctl completion bash 
starship completions bash 
velero completion bash 
chezmoi completion bash
kustomize completion bash 
cilium completion bash 
argo completion bash 
kubesec completion bash 
} > $BASHDIR
echo "Fish autocompletions"
FISHDIR="/usr/share/fish/vendor_completions.d/boombox"
{
helm completion fish 
flux completion fish 
starship completions fish 
velero completion fish 
chezmoi completion fish 
kustomize completion fish 
cilium completion fish 
argo completion fish 
kubesec completion fish 
} > $FISHDIR
