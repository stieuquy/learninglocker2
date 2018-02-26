#!/bin/sh
set -e

export DOCKER_TAG=latest
docker build -t hoangvubrvt/learninglocker:$DOCKER_TAG app
docker build -t hoangvubrvt/learninglocker:$DOCKER_TAG nginx

