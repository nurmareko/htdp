;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |253|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [Number -> Boolean]
(zero? 0)
(complex? 10)

; [Boolean String -> Boolean]
(define (f0 b s)
  (and b (string=? s "a")))

; [Number Number Number -> Number]
(+ 1 2 3)
(* 10 2 0)

; [Number -> [List-of Number]]
(define (f1 n)
  (list n))

; [[List-of Number] -> Boolean]
(define (f1 l)
  (member? 0 l))