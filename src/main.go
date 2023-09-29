package main

import "log"
import "fmt"
//import "strconv"
import "net/http"
import "database/sql"
import _ "github.com/lib/pq"

var pool *sql.DB

func main() {
	var err error
	pool, err = sql.Open("postgres", "postgres://postgres@10.0.10.3/postgres?sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer pool.Close()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		var hits string
		err = pool.QueryRow("select value from counter where key = 'hits'").Scan(&hits)
		if err != nil {
			log.Fatal(err)
		}

		_, err = pool.Exec("update counter set value = value + 1 where key = 'hits'")
		if err != nil {
			log.Fatal(err)
		}
		fmt.Fprintf(w, "Hello, there have been %v requests made to this server!\n", hits)
	})


	log.Fatal(http.ListenAndServe(":8000", nil))
}
