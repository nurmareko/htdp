;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |320|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; An S-expr is one of: 
; – Number
; – String
; – Symbol
; - '()
; – [NEList-of S-expr]
;====================================================;
; S-expr Symbol -> N 
; counts all occurrences of sy in sexp

(check-expect (count 69 'hello) 0)
(check-expect (count "hello" 'hello) 0)
(check-expect (count '() 'hello) 0)
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

(define (count sexp sy)
  (cond
    [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
    [(and (list? sexp) (not (empty? sexp)))
     (foldr + 0 (map (lambda (s) (count s sy)) sexp))]
    [else 0]))
;=321================================================;
; An [S-expr X] is one of: 
; – [S-expr Atom]
; – [S-expr [List-of S-expr]]

; An Atom is Any value that hold true to atom?
; Any -> Boolean
;(define (atom? v)
;  (or (equal? atom-1 v) ... (equal? atom-n v)))