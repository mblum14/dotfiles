source "$HOME/.local/bin/lib/log.sh"

# Execute a command with an AWS profile or set the AWS_PROFILE to the target
function aws.login() {
  # Check if the AWS_PROFILE argument is provided
  if [[ -z "$1" ]]; then
    echo "Usage: aws.login <AWS_PROFILE> [command...]"
    return 1
  fi

  local profile="$1"
  shift

  if [[ $# -eq 0 ]]; then
    export AWS_PROFILE="${profile}"
  fi

  if ! aws sts get-caller-identity --query "Account" --profile "${profile}" >/dev/null 2>&1; then
    log::info "AWS Session expired, requesting credentials for ${profile}"
    aws sso login --profile "${profile}"
  fi

  # Execute the command with AWS_PROFILE set
}
