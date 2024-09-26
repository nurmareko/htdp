;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |459|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define R 300000)
(define ε 0.01)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within (integrate-rectangles (lambda (x) 20) 12 22) 200 ε)
(check-within (integrate-rectangles (lambda (x) (* 2 x)) 0 10) 100 ε)
(check-within (integrate-rectangles (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              ε)
 
(define (integrate-rectangles f a b)
  (local ((define RR (- R 1))
          (define W (/ (- b a) R))
          (define S (/ W 2))
          ;Number Number Number -> Number
          (define (integrate a b n)
            (cond
              [(= n RR) 0]
              [else
               (+ (* W (f (+ a (* n W) S)))
                  (integrate a b (add1 n)))])))
    (integrate a b 0)))