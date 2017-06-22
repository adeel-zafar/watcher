package main

import (
	"bytes"
	"fmt"
	"io"
	"log"
	"net/http"
)

func main() {
	h := http.NewServeMux()
	h.Handle("/watcher", http.StripPrefix("/watcher", http.HandlerFunc(watcherHandler)))
	h.Handle("/", http.StripPrefix("/", http.HandlerFunc(assetsHandler)))

	err := http.ListenAndServe(":8080", h)
	log.Fatal(err)

}

func watcherHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "200")
}

func assetsHandler(w http.ResponseWriter, r *http.Request) {
	var path = r.URL.Path
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
