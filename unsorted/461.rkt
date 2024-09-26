;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |461|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define ε 0.01)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds

(check-within (integrate-adaptive (lambda (x) 20) 12 22) 200 ε)
(check-within (integrate-adaptive (lambda (x) (* 2 x)) 0 10) 100 ε)
(check-within (integrate-adaptive (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              ε)

(define (integrate-adaptive f a b)
  (local (; Number Number -> Number
          (define (kepler a b)
            (* 1/2 (- b a) (+ (f a) (f b))))
          ;=================================;
          (define original (kepler a b))
          (define small (* ε (- b a)))
          (define mid (/ (+ a b) 2))
          (define first-half (kepler a mid))
          (define second-half (kepler mid b)) 
          (define difference (abs (- first-half second-half))))
  (cond
    [(< difference small) original]
    [else
       (+ (integrate-adaptive f a mid)
          (integrate-adaptive f mid b))])))
