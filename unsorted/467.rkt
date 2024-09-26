;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |467|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An SOE is a [NEList-of Equation]
; constraint:
;   for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation:
;   represents a system of linear equations
 
; An Equation is a [List-of Number].
; constraint:
;   an Equation contains at least two numbers. 
; interpretation:
;   if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable
; coefficients  and b is the right-hand side

; A TM is an [NEList-of Equation]
; such that the Equations are of decreasing length: 
;   n + 1, n, n - 1, ..., 2. 
; interpretation:
;   represents a triangular matrix

(define REC
  (list (list 2  3  3 8)
        (list 2  3 -2 3)
        (list 4 -2  2 4)))
(define TRI
  (list (list 2  3  3   8)
        (list   -8 -4 -12)
        (list      -5  -5)))
;====================================================;
; Equation Equation -> Equation
; subtracts a multiple of the second equation from
; the first, item by item
(define (subtract first-eq second-eq)
  (local ((define MUL (/ (first first-eq) (first second-eq))))
    (map (lambda (x y) (- x (* y MUL)))
         (rest first-eq)
         (rest second-eq))))
;====================================================;
; SOE -> TM
; triangulates the given system of equations

(check-expect (triangulate '((1 2))) '((1 2)))
(check-expect (triangulate '(( 3  9  21)
                             (-3 -8 -19)))
                           '((3 9 21)
                             (  1  2)))
(check-expect (triangulate '((0  -5  -5)
                             (-8 -4 -12)))
                           '((-8 -4 -12)
                             (   -5 -5)))
(check-expect (triangulate REC) TRI)

(define (triangulate M)
  (cond
    [(empty? (rest M)) M]
    [else
     (local ((define checked-M
               (if (zero? (first (first M)))
                   (append (rest M) (list (first M)))
                   M))
             (define initial (first checked-M))           
             (define remaining (rest checked-M))
             (define simplified-rest
               (map (lambda (eq) (subtract eq initial)) remaining)))       
       (cons initial
             (triangulate simplified-rest)))]))
