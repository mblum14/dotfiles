# Execute a command with an AWS profile or set the AWS_PROFILE to the target
function aws.login() {
  # Check if the AWS_PROFILE argument is provided
  if [[ -z "$1" ]]; then
    echo "Usage: aws.login <AWS_PROFILE> [command...]"
    return 1
  fi

  local profile="$1"
  shift

  if aws sso login --profile "${profile}"; then
    export AWS_PROFILE="${profile}"
  fi
}
