#!/bin/bash

is_docker_up () {
  docker info > /dev/null 2>&1
  return $?
}

echo -n 'Waiting for docker'
count=0
timeout=600 # 10minutes
until is_docker_up ; do
  echo -n '.'
  sleep 1
  
  if (( $count >= $timeout )); then
    echo 'Timed out waiting for docker'
    exit 1
  fi
  count=$[$count + 1]
done
echo ''
echo 'Docker is ready!'
