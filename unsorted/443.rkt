;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |443|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define (gcd-structural n m)
  (cond
    [(and (= n 1) (= m 1)) ...]
    [(and (> n 1) (= m 1)) ...]
    [(and (= n 1) (> m 1)) ...]
    [else
     (... (gcd-structural (sub1 n) (sub1 m)) ...
      ... (gcd-structural (sub1 n) m) ...
      ... (gcd-structural n (sub1 m)) ...)]))
;====================================================;
; in order to find the greatest common divisor of two
; numbers we need the initial value of the original
; problem, therefore it is imposible to retain the
; value of the original problems using template shown
; above.