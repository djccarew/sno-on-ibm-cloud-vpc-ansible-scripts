#!/bin/bash
DOCKER_COMMAND=$(command -v podman  || command -v docker)

if [ $? -ne 0 ]
then
  echo "Fatal error: podman or docker must be available in your PATH" >&2
  exit 1
fi

if [ $# -eq 0 ]
then
   $DOCKER_COMMAND run -it --rm --platform=linux/amd64  -v $(pwd)/params:/ansible/group_vars -v $(pwd)/auth:/ansible/auth -v $(pwd)/state:/ansible/state quay.io/clouddragons/sno-ibm-cloud-ansible:2.0.0 /bin/bash
else
   echo "Launching custom image $1 ..."
   $DOCKER_COMMAND run -it --rm --platform=linux/amd64  -v $(pwd)/params:/ansible/group_vars -v $(pwd)/auth:/ansible/auth -v $(pwd)/state:/ansible/state  $1 /bin/bash 
fi
