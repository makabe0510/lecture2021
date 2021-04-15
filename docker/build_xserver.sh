#!/bin/bash
set -e

export BASE_IMAGE=nvidia/opengl:1.2-glvnd-runtime-ubuntu18.04
TEMP_IMAGE=temp_xserver:latest

##
cd build

git clone -b build_from_baseimage https://github.com/YoheiKakiuchi/docker-xserver.git

cd docker-xserver

docker build . --no-cache -f Dockerfile --build-arg BASE_IMAGE=${BASE_IMAGE} -t ${TEMP_IMAGE}

## output: jsk_robotics/agent_system_xserver:2021
docker build . -f Dockerfile.wrap_euslisp --build-arg BASE_IMAGE=${TEMP_IMAGE} -t jsk_robotics/agent_system_xserver:2021

##
docker image rm ${TEMP_IMAGE}
cd ../..
