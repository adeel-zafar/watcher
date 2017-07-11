#!/bin/bash
source env.sh
cd $ROOT
############### FUNCTIONS #############
usage() {
  echo "Usage: $0 [ -e <prod|dev> ] " 1>&2;
  exit 1
}

build_assets() {
  echo "Building assets..."
  case "${1}" in
    dev)
        ${GO_BINDATA} -o ${ASSETS_GEN} -prefix ${STATIC_ASSETS}/${ENV} ${STATIC_ASSETS}/${ENV}/...
        ;;
    prod)
        ${GO_BINDATA} -o ${ASSETS_GEN} -nocompress -debug -prefix ${STATIC_ASSETS}/${ENV} ${STATIC_ASSETS}/${ENV}/...
        ;;
  esac

}

build_go() {
  echo "Building go..."
  go build -o ${TARGET} ${SOURCE}
}

build() {
  echo "Build env: $1"
  if [ $2 != 'y' ]; then
    build_assets $1
  fi

  build_go
}

############### MAIN #############
ENV="dev"
SKIP_ASSETS="n"

while getopts ":e:s" o; do
  case "${o}" in
    e)
      ENV=${OPTARG}
      ((ENV == "dev" || ENV == "prod")) || usage
      ;;
    s)
      SKIP_ASSETS="y"
      ;;
    *)
      usage
      ;;
  esac
done

build $ENV $SKIP_ASSETS
