;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |463|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; constraint for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation represents a system of linear equations
 
; An Equation is a [List-of Number].
; constraint an Equation contains at least two numbers. 
; interpretation if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable coefficients 
; and b is the right-hand side
 
; A Solution is a [List-of Number]
;====================================================;
; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(define (lhs e)
  (reverse (rest (reverse e))))
 
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(define (rhs e)
  (first (reverse e)))

; SOE Solution -> Boolean
; Its result is #true if plugging in the numbers from
; the Solution for the variables in the Equations of
; the SOE produces equal left-hand-side values and
; right-hand-side values; otherwise the function
; produces #false.
(define (check-solution soe solution)
  (andmap (lambda (x)
            (= (plug-in (lhs x) solution) (rhs x)))
          soe))

; [List-of Number] Solution -> Number
; calculates out the value of the left-hand side when
; the numbers from the solution are plugged in for
; the variables.

(define (plug-in left-hand solution)
  (foldr (lambda (lh sol re) (+ (* lh sol) re))
         0
         left-hand solution))
;====================================================;
(define M-SQU
  (list (list 2 2  3 10)
        (list 2 5 12 31)
        (list 4 1 -2  1)))

(define M-TRI
  (list (list 2 2 3 10)
        (list 0 3 9 21)
        (list 0 0 1  2)))
 
(define S '(1 1 2))

(check-expect (check-solution M-SQU S)
              (check-solution M-TRI S))
