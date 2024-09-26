;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |317|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; An S-expr is one of: 
; – Atom
; – SL

; An SL is one of: 
; – '()
; – (cons S-expr SL)

; An Atom is one of: 
; – Number
; – String
; – Symbol
; Atom predicate:
(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))
;=317================================================;
; S-expr Symbol -> N 
; counts all occurrences of sy in sexp

;(check-expect (count 'world 'hello) 0)
;(check-expect (count '(world hello) 'hello) 1)
;(check-expect (count '(((world) hello) hello) 'hello) 2)
;
;(define (count sexp sy)
;  (local ((define (count-sl sl)
;            (cond
;              [(empty? sl) 0]
;              [else
;               (+ (count (first sl) sy)(count-sl (rest sl)))]))
;          (define (count-atom at)
;            (cond
;              [(number? at) 0]
;              [(string? at) 0]
;              [(symbol? at) (if (symbol=? at sy) 1 0)])))
;    (cond
;      [(atom? sexp) (count-atom sexp)]
;      [else (count-sl sexp)])))
;=318================================================;
; S-expr -> N
; determines sexp depth.
; An Atom has a depth of 1. The depth of a list of
; S-expressions is the maximum depth of its items
; plus 1.

(check-expect (depth 0) 1)
(check-expect (depth "a") 1)
(check-expect (depth 'a) 1)
(check-expect (depth '()) 1)
(check-expect (depth '(0)) 2)
(check-expect (depth '(0 "a" a)) 2)
(check-expect (depth '(0 "a" (a b c))) 3)
(check-expect (depth '((0 (0)) "a" (a b c))) 4)

(define (depth sexp)
  (cond
    [(atom? sexp) (depth-at sexp)]
    [else (+ 1 (depth-sl sexp))]))

; SL -> N
; determines sl depth.
; The depth of SL is the maximum depth of its items
; plus 1.
(define (depth-sl sl)
  (cond
    [(empty? sl) 0]
    [else
     (max (depth (first sl)) (depth-sl (rest sl)))]))

; Atom -> N
; determines at depth.
; An Atom has a depth of 1
(define (depth-at at)
  (if (atom? at) 1 #false))






















