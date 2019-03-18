#!/bin/sh
set -e
if [ -z "$config_base64" ]; then
    config_base64=$(AWS_DEFAULT_REGION=$CONFIG_PARAMETER_REGION /get-ssm --parameter-name $CONFIG_PARAMETER_NAME)
fi
echo $config_base64 | base64 -d > /config/config.yml

/clair --config /config/config.yml --log-level=$LOG_LEVEL
