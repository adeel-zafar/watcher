#!/bin/bash
source env.sh

############### FUNCTIONS #############
usage() {
  echo "Usage: $0 [ -e <prod|dev> ] " 1>&2;
  exit 1
}

build_assets() {
  echo "Building assets..."
  ${GO_BINDATA} -o ${ASSETS_GEN} $* -prefix ${STATIC_ASSETS}/${ENV} ${STATIC_ASSETS}/${ENV}/...
}

build_go() {
  echo "Building go..."
  go build -o ${TARGET} ${SOURCE}
}

build_dev() {
  echo "Build env: DEV"
  build_assets -nocompress -debug
  build_go
}

build_prod() {
  echo "Build env: PROD"
  build_assets
  build_go
}

############### MAIN #############
ENV="dev"

while getopts ":e:" o; do
  case "${o}" in
    e)
      ENV=${OPTARG}
      ((ENV == "dev" || ENV == "prod")) || usage
      ;;
    *)
      usage
      ;;
  esac
done

case "${ENV}" in
  dev)
      build_dev
      ;;
  prod)
      build_prod
      ;;
  *)
      usage
      ;;
esac
