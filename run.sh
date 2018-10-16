#!/bin/sh
set -e
config_base64=$(AWS_DEFAULT_REGION=$CONFIG_PARAMETER_REGION /get-ssm --parameter-name $CONFIG_PARAMETER_NAME)
echo $config_base64 | base64 -d > /config/config.yml
/clair --config /config/config.yml
