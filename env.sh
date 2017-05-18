ROOT=`pwd`
GO_BIN="${GOPATH}/bin"
PATH="$PATH:$GO_BIN"
GO_BINDATA="go-bindata"
STATIC_ASSETS="./assets/static"
ASSETS_GEN="bindata.go"
SOURCE="*.go"
TARGET="build/watcher"
