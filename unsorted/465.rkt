;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |465|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An Equation is a [List-of Number].
; constraint an Equation contains at least two numbers. 
; interpretation if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable coefficients 
; and b is the right-hand side
;====================================================;
; Equation Equation -> Equation
; subtracts a multiple of the second equation from
; the first, item by item

(check-expect (subtract '(2 5 12 31) '(2 2  3 10))
               '(3 9 21))
(check-expect (subtract '(4 1 -2  1) '(2 2  3 10))
               '(-3 -8 -19))

(define (subtract first-eq second-eq)
  (local ((define MUL (/ (first first-eq) (first second-eq))))
    (map (lambda (x y) (- x (* y MUL)))
         (rest first-eq)
         (rest second-eq))))
