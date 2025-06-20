#!/usr/bin/env bash

account="$(aws sts get-caller-identity --query 'Account' --output text)"
region="${AWS_REGION:-us-east-1}"
aws --region "${region}" ecr get-login-password |
  docker login --username AWS --password-stdin "${account}.dkr.ecr.${region}.amazonaws.com"
