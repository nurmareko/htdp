;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |469|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An SOE is a [NEList-of Equation]
; constraint:
;  for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation:
;  represents a system of linear equations

; An Equation is a [List-of Number].
; constraint:
;  an Equation contains at least two numbers. 
; interpretation:
;  if (list a1 ... an b) is an Equation, a1, ..., an
; are the left-hand-side variable coefficients 
; and b is the right-hand side

; A Solution is a [List-of Number]

; A TM is an [NEList-of Equation]
; such that the Equations are of decreasing length: 
;   n + 1, n, n - 1, ..., 2. 
; interpretation:
;   represents a triangular matrix
(define TM
  (list (list 2 2 3 10)
        (list   3 9 21)
        (list     1  2)))
;====================================================;
; TM -> Solution
; produce a solution for triangular matrix.

(check-expect (solve '((1 2))) '(2))
(check-expect (solve '((3 9 21) (1 2))) '(1 2))
(check-expect (solve TM) '(1 1 2))

(define (solve matrix)
  (local (; Equation Solution -> Solution
          (define (find-value eq solution)
            (local ((define coefficient (lhs eq))
                    (define constant (rhs eq))
                    (define plugged (plug-in (rest coefficient) solution)))
              (cons (/ (- constant plugged) (first coefficient))
                    solution))))
  (foldr find-value '() matrix)))

;(define (solve matrix)
;  (cond
;    [(empty? matrix) '()]
;    [else
;     (find-value (first matrix)
;                 (solve (rest matrix)))]))

; Equation Solution -> Solution
; find the value of the variable of the first
; coefficient of an equation

;(check-expect (find-value '(1 2) '()) '(2))
;(check-expect (find-value '(3 9 21) '(2)) '(1 2))
;(check-expect (find-value '(2 2 3 10) '(1 2)) '(1 1 2))
 
;(define (find-value eq solution)
;  (local ((define coefficient (lhs eq))
;          (define constant (rhs eq)))
;    (cons (/ (- constant (plug-in (rest coefficient) solution)) (first coefficient))
;          solution)))

;====================================================;
; [List-of Number] Solution -> Number
; calculates out the value of the left-hand side when
; the numbers from the solution are plugged in for
; the variables.
(define (plug-in left-hand solution)
  (foldr (lambda (lh sol re) (+ (* lh sol) re))
         0
         left-hand solution))

; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(define (lhs e)
  (reverse (rest (reverse e))))
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(define (rhs e)
  (first (reverse e)))