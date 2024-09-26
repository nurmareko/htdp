;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |455 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define ε 0.001)

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

; Number -> Boolean
(define (within? n)
  (= 0 (poly (round n))))

;====================================================;
; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R EPSILON)]
; assume f is continuous 
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in 
; one of the two halves, picks according to (2)

(check-satisfied (find-root poly 1 3) within?)
(check-satisfied (find-root poly 3 6) within?)

(define (find-root f left right)
  0)