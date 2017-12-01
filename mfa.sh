#!/bin/bash
#
# mfa.sh ARN_OF_MFA MFA_TOKEN_CODE
#
# export AWS_ACCESS_KEY_ID='KEY'
# export AWS_SECRET_ACCESS_KEY='SECRET'
# export AWS_SESSION_TOKEN='TOKEN'
#
# source ~/.aws/.token_file
#

AWS_CLI=`which aws`

if [ $? -ne 0 ]; then
  echo "AWS CLI is not installed; exiting"
  exit 1
else
  echo "Using AWS CLI found at $AWS_CLI"
fi


MFA_TOKEN_CODE=$2
ARN_OF_MFA=$1

echo "Your Temporary Creds:"
output=$(aws sts get-session-token --duration 129600   --serial-number $ARN_OF_MFA --token-code $MFA_TOKEN_CODE --output text)

AWS_ACCESS_KEY_ID=$(echo ${output}| awk '{printf ($2)}')
AWS_SECRET_ACCESS_KEY=$(echo ${output}| awk '{printf ($4)}')
AWS_SESSION_TOKEN=$(echo ${output}| awk '{printf ($5)}')
AWS_SECURITY_TOKEN=$(echo ${output}| awk '{printf ($5)}')

aws --profile mfa configure set AWS_ACCESS_KEY_ID ${AWS_ACCESS_KEY_ID}
aws --profile mfa configure set AWS_SECRET_ACCESS_KEY ${AWS_SECRET_ACCESS_KEY}
aws --profile mfa configure set AWS_SESSION_TOKEN ${AWS_SESSION_TOKEN}
aws --profile mfa configure set AWS_SECURITY_TOKEN ${AWS_SECURITY_TOKEN}
aws --profile mfa configure set region eu-west-1
aws --profile mfa configure set output table
