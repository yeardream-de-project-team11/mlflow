#!/bin/bash

if [[ $SERVICE_TYPE == 'server' ]]; then
  exec ./run_server.sh
elif [[ $SERVICE_TYPE == 'serving' ]]; then
  exec ./run_serving.sh
else
  echo "No or invalid service type specified" 1>&2
  exit 1
fi