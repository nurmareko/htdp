;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |462|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An SOE is a non-empty Matrix.
; constraint for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation represents a system of linear equations
 
; An Equation is a [List-of Number].
; constraint an Equation contains at least two numbers. 
; interpretation if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable coefficients 
; and b is the right-hand side
 
; A Solution is a [List-of Number]
 
(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))
 
(define S '(1 1 2)) ; a Solution

; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(check-expect (lhs (first M)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))
 
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(check-expect (rhs (first M)) 10)
(define (rhs e)
  (first (reverse e)))
;====================================================;
; SOE Solution -> Boolean
; Its result is #true if plugging in the numbers from
; the Solution for the variables in the Equations of
; the SOE produces equal left-hand-side values and
; right-hand-side values; otherwise the function
; produces #false.

(check-expect (check-solution M S) #true)

(define (check-solution soe solution)
  (andmap (lambda (x)
            (= (plug-in (lhs x) solution) (rhs x)))
          soe))

;(define (check-solution soe solution)
;  (cond
;    [(empty? soe) #true]
;    [else
;     (and (= (plug-in (lhs (first soe)) solution) (rhs (first soe)))
;          (check-solution (rest soe) solution))]))
;====================================================;
; [List-of Number] Solution -> Number
; calculates out the value of the left-hand side when
; the numbers from the solution are plugged in for
; the variables.

(check-expect (plug-in (lhs (first M)) S) 10)

(define (plug-in left-hand solution)
  (foldr (lambda (lh sol re) (+ (* lh sol) re))
         0
         left-hand solution))

;(define (plug-in left-hand solution)
;  (cond
;    [(empty? left-hand) 0]
;    [else
;     (+ (* (first left-hand) (first solution))
;        (plug-in (rest left-hand) (rest solution)))]))
