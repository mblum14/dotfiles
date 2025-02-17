source "$HOME/.local/bin/lib/log.sh"

# [K]ubectl [S]et [C]ontext
function k.sc() {
  if [[ -z $AWS_PROFILE ]] && [[ -z $AWSUME_PROFILE ]]; then
    log::err "No \$AWS_PROFILE"
    return 3
  fi

  cluster_name=$1

  if [[ -z $cluster_name ]]; then
    cluster_name="$(aws eks list-clusters --query 'clusters[]' | jq -r '.[]' | fzf-tmux -p --header="Select cluster")"
  fi

  if [[ -z $cluster_name ]]; then
    log::err "missing cluster name"
    echo "kube.sc <cluster_name>"
    return 1
  fi

  aws eks update-kubeconfig --name "${cluster_name}"
}

# [k]ubectl [S]et [N]amespace
function k.sn() {
  namespace=$1

  if [[ -z $namespace ]]; then
    namespace="$(kubectl get namespace | tail -n +2 | awk '{print $1}' | fzf-tmux -p --header="Select namespace")"
  fi

  if [[ -z $namespace ]]; then
    log::err "missing namespace"
    echo "kube.sn <namespace>"
    return 1
  fi

  kubectl config set-context --current --namespace=$namespace
}

# [k]ubectl [C]lear [C]ontext
function k.cc() {
  kubectl config unset current-context
}

# [K]ubectl [G]et [P]ods
function k.gp() {
  local context
  command='kubectl get pods --all-namespaces'
  context="$(kubectl config current-context | sed 's/-context$//')"

  # TODO: fix this
  kubectl get pods -A | fzf \
    --info=inline --layout=reverse --header-lines=1 \
    --prompt "${context}> " \
    --header $'╱ Enter (kubectl exec) ╱ CTRL-O (open log in editor) ╱ CTRL-R (reload) ╱\n\n' \
    --bind 'start:reload:$command' \
    --bind 'ctrl-r:reload:$command' \
    --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' \
    --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- bash > /dev/tty' \
    --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --all-containers --namespace {1} {2}) > /dev/tty' \
    --preview-window up:follow \
    --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@"
}
