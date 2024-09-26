;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |281|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
((lambda (x) (< x 10)) 5)

((lambda (n1 n2) (number->string (* n1 n2))) 2 5)

((lambda (n) (if (odd? n) 1 0)) 4)

(define-struct IR [name price])

((lambda (a b) (< (IR-price a) (IR-price b)))
 (make-IR "a" 10) (make-IR "b" 30))

(define DOT (circle 5 "solid" "red"))
(define MT (empty-scene 200 200))

((lambda (p im) (place-image DOT (posn-x p) (posn-y p) im))
 (make-posn 20 60) MT)
