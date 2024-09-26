;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |437 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [X] [List-of X] -> Number
; compute the length of P

(check-expect (special-0 '()) 0)
(check-expect (special-0 '(#true)) 1)
(check-expect (special-0 '(1 "two" ())) 3)

(define (special-0 P)
  (cond
    [(empty? P) (solve-0 P)]
    [else
     (combine-solutions-0
       1
       (special-0 (rest P)))]))

; [X] [List-of X] -> Number
; ...
(define (solve-0 x) 0)

; [X] Number Number -> Number
; ...
(define (combine-solutions-0 x y) (+ x y))
;====================================================;
; [List-of Number] -> [list-of Number]
; negates each number on P

(check-expect (special-1 '()) '())
(check-expect (special-1 '(1 2 3)) '(-1 -2 -3))
(check-expect (special-1 '(0 0 0)) '(0 0 0))

(define (special-1 P)
  (cond
    [(empty? P) (solve-1 P)]
    [else
     (combine-solutions-1
       (- (first P) (* (first P) 2))
       (special-1 (rest P)))]))

; [List-of Number] -> [List-of Number]
; ...
(define (solve-1 x) x)

; [X] Number [List-of Number] -> [List-of Number]
; ...
(define (combine-solutions-1 x y) (cons x y))
;====================================================;
; [List-of String] -> [List-of String]
; uppercases each string in P

(check-expect (special-2 '()) '())
(check-expect (special-2 '("hello")) '("HELLO"))
(check-expect (special-2 '("hello" "WORLD"))
              '("HELLO" "WORLD"))
(check-expect (special-2 '("")) '(""))

(define (special-2 P)
  (cond
    [(empty? P) (solve-2 P)]
    [else
     (combine-solutions-2
       (string-upcase (first P)) 
       (special-2 (rest P)))]))

; [List-of String] -> [List-of String]
; ...
(define (solve-2 x) x)

; [X] String [List-of String] -> [List-of String]
; ...
(define (combine-solutions-2 x y) (cons x y))
;====================================================;
; the template for generative recursion can be use for
; structural recursion, therefore structural recursion
; is some form of generative recursion.