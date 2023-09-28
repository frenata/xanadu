package main

import "log"
import "fmt"
import "net/http"
//import "github.com/lib/pq"

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello")
	})

	log.Fatal(http.ListenAndServe(":8000", nil))
}
