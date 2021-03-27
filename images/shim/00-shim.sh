[ "$BASH_VERSION" != "" ] || [ "$ZSH_VERSION" != "" ] || return 0
[ "$PS1" != "" ] || return 0

curl https://artii.herokuapp.com/make?text=DevOps+Toolbox
echo ""
echo "Starting ansible-pull provision..."
echo "manually run with provision"

export PATH="/usr/libexec/toolbox:$PATH"

sleep 1

nohup ansible-pull -U https://github.com/anthr76/tooling.git -i "$(uname -n)," --diff -e playbook_dir shim/local.yml &>/tmp/last-ansible-pull &

alias provision="ansible-pull -U https://github.com/anthr76/tooling.git -i "$(uname -n)," -e playbook_dir shim/local.yml"