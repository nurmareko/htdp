;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |251|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> Number
; computes the sum of 
; the numbers on l

(check-expect (sum '()) 0)
(check-expect (sum (list 1 2 3)) 6)

(define (sum l)
  (cond
    [(empty? l) 0]
    [else
     (+ (first l)
        (sum (rest l)))]))

; [List-of Number] -> Number
; computes the product of 
; the numbers on l

(check-expect (product '()) 1)
(check-expect (product (list 1 2 3)) 6)

(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product (rest l)))]))
;====================================================;
; [Number Number -> Num] Number [List-of Number]
; -> Number
(define (fold1 F b ln)
  (cond [(empty? ln) b]
        [else (F (first ln) (fold1 F b (rest ln)))]))

; [List-of Number] -> Number
; computes the sum of the numbers on ln

(check-expect (sum0 '()) 0)
(check-expect (sum0 (list 1 2 3)) 6)

(define (sum0 ln)
  (fold1 + 0 ln))

; [List-of Number] -> Number
; computes the product of the numbers on ln

(check-expect (product0 '()) 1)
(check-expect (product0 (list 1 2 3)) 6)

(define (product0 ln)
  (fold1 * 1 ln))