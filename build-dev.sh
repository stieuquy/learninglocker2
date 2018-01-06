#!/bin/sh
set -e

export DOCKER_TAG=master
docker build -t hoangvubrvt/learninglocker:$DOCKER_TAG app
docker build -t hoangvubrvt/learninglocker:$DOCKER_TAG nginx

