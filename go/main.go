package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
	"strconv"
)

func redirectHandler(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, "/to", 301)
}

func toHandler(w http.ResponseWriter, r *http.Request) {
	log.Print("redirected!")
	fmt.Fprintf(w, "redirected, %q", html.EscapeString(r.URL.Path))
}

func downloadHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Disposition", "attachment; filename="+strconv.Quote("daido1976-icon.png"))
	w.Header().Set("Content-Type", "application/octet-stream")
	http.ServeFile(w, r, "./image/daido1976-icon.png")
}

func main() {
	fs := http.FileServer(http.Dir("./public"))
	http.Handle("/", fs)
	http.HandleFunc("/redirect", redirectHandler)
	http.HandleFunc("/to", toHandler)
	http.HandleFunc("/download", downloadHandler)

	log.Print("Start server on http://localhost:3000/")
	err := http.ListenAndServe(":3000", nil)
	if err != nil {
		log.Fatal(err)
	}
}
