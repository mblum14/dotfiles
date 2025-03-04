source "$HOME/.local/bin/lib/log.sh"

function aws.logout() {
  if [[ -n $AWS_PROFILE ]]; then
    aws sso logout --profile "${AWS_PROFILE}"
  fi
  unset AWS_PROFILE
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_ACCESS_KEY_ID
  unset AWS_SESSION_TOKEN
}
