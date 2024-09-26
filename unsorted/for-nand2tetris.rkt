;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname for-nand2tetris) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;(define n "0")
;
;(string-append
; "    And (a=a["
;
; n
;
; "], b=b["
;
; n
;
; "], out=out["
;
; n
;
; "]);")

(define MAX 16)

; N -> String
; ...
(define (multiple n)
  (cond
    [(= MAX n) ""]
    [else
     (local (
             (define n-as-str (number->string n))
             )
     (string-append
      "    Mux (a=a[" n-as-str "], b=b[" n-as-str "], out=out[" n-as-str "]);\n"
      (multiple (add1 n))))]))

(write-file 'stdout (multiple 0))



















