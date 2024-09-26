;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |458|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define ε 0.1)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within (integrate-kepler (lambda (x) 20) 12 22) 200 ε)
(check-within (integrate-kepler (lambda (x) (* 2 x)) 0 10) 100 ε)
(check-within (integrate-kepler (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              ε)
 
(define (integrate-kepler f a b)
  (* 0.5 (- b a) (+ (f a) (f b))))

; the third case fail by 50% error
