#!/bin/bash

############### FUNCTIONS #############
usage() {
  echo "Usage: $0 [command] " 1>&2;
  exit 1
}

############### MAIN #############
if [ $# -lt 1 ]; then
  usage
fi

COMMAND=$1
shift
cd scripts

case "$COMMAND" in
  build)
      ./build.sh $*
      ;;
  install)
      ./install.sh $*
      ;;
  generate)
      ./generate.sh $*
      ;;
  *)
      usage
      ;;
esac
