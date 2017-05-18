package main

import (
	"log"
	"io"
	"bytes"
	"net/http"
	"fmt"
)

func main() {
	h := http.NewServeMux()
	h.Handle("/watcher", http.StripPrefix("/watcher", http.HandlerFunc(watcher_handler)))
	h.Handle("/", http.StripPrefix("/", http.HandlerFunc(assets_handler)))

	err := http.ListenAndServe(":8080", h)
	log.Fatal(err)

}

func watcher_handler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "200")
}

func assets_handler(w http.ResponseWriter, r *http.Request) {
	var path string = r.URL.Path
  if path == "" {
    path = "html/index.html"
  }
  if bs, err := Asset(path); err != nil {
    w.WriteHeader(http.StatusNotFound)
  } else {
    var reader = bytes.NewBuffer(bs)
    io.Copy(w, reader)
  }
}
