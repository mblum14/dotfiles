#!/usr/bin/env bash

source "$HOME/.local/bin/lib/log.sh"

function aws.login() {
	log::info "setting aws profile to $1"
	export AWS_PROFILE=$1
}

# kubectl [S]et [C]ontext
function kube.sc() {
	if [[ -z $AWS_PROFILE ]]; then
		log::err "No \$AWS_PROFILE or C2S Credentials set"
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

# kubectl [S]et [N]amespace
function kube.sn() {
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
