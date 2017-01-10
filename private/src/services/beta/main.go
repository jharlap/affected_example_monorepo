package main

import (
	"fmt"
	"net/http"
	"strconv"
	"strings"
)

func main() {
	// increment the path param x in /increment/:x
	http.HandleFunc("/increment/", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ws := strings.Split(r.URL.Path, "/")
		if len(ws) < 3 {
			w.WriteHeader(http.StatusBadRequest)
			fmt.Fprint(w, `{"error":"missing expected x value in /increment/:x"}`) // #nosec
			return
		}

		x, err := strconv.Atoi(ws[2])
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			fmt.Fprint(w, `{"error":"x must be numeric"}`) // #nosec
			return
		}
		x2 := increment(x)
		fmt.Fprintf(w, `{"x":%d,"increment":%d}`, x, x2) // #nosec
	}))
	fmt.Println("beta starting")
	fmt.Println(http.ListenAndServe(":80", nil))
}

func increment(x int) int {
	return x + 1
}
