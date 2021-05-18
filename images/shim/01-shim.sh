[ "$BASH_VERSION" != "" ] || [ "$ZSH_VERSION" != "" ] || return 0
[ "$PS1" != "" ] || return 0

export PATH="/usr/libexec/toolbox:$PATH"

alias provision="yay -Syu - < /opt/pkgs"