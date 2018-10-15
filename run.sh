#!/bin/sh
set -e
/get-ssm --parameter-name $CONFIG_PARAMETER_NAME
config_base64=$(/get-ssm --parameter-name $CONFIG_PARAMETER_NAME)
echo $config_base64
echo $config_base64 | base64 -d > /config/config.yml
cat /config/config.yml
/clair --config /config/config.yml
