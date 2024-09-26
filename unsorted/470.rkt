;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |470|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An SOE is a [NEList-of Equation]
; constraint:
;  for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation:
;  represents a system of linear equations
; example:
(define M ; an SOE 
  '((2 2  3 10) ; an Equation
    (2 5 12 31)
    (4 1 -2  1)))

; An Equation is a [List-of Number].
; constraint:
;  an Equation contains at least two numbers. 
; interpretation:
;  if (list a1 ... an b) is an Equation, a1, ..., an
; are the left-hand-side variable coefficients 
; and b is the right-hand side

; A Solution is a [List-of Number]
; example:
(define S '(1 1 2))

; A TM is an [NEList-of Equation]
; such that the Equations are of decreasing length: 
;   n + 1, n, n - 1, ..., 2. 
; interpretation:
;   represents a triangular matrix

;====================================================;
; SOE -> Solution
; find the solution for variables in an system of
; equation

(check-expect (gauss M) S)
(check-error (gauss '((2 2 2) (2 2 4) (2 2 1))))

(define (gauss matrix)
  (solve (triangulate matrix)))
;====================================================;
; SOE -> TM
; triangulates the given system of equations
(define (triangulate M)
  (cond
    [(empty? (rest M)) M]
    [((lambda (m) (andmap (lambda (eq) (zero? (first eq))) m)) M)
     (error "No solution, all equations lead by 0")]
    [else
     (local ((define checked-M
               (if (zero? (first (first M)))
                   (append (rest M) (list (first M)))
                   M))
             (define initial (first checked-M))           
             (define remaining (rest checked-M))
             ; Equation Equation -> Equation
             (define (subtract first-eq second-eq)
               (local ((define MUL (/ (first first-eq) (first second-eq))))
                 (map (lambda (x y) (- x (* y MUL)))
                      (rest first-eq)
                      (rest second-eq))))
             (define simplified-rest
               (map (lambda (eq) (subtract eq initial)) remaining)))       
       (cons initial
             (triangulate simplified-rest)))]))
;====================================================;
; TM -> Solution
; produce a solution for triangular matrix.
(define (solve matrix)
  (local (; Equation Solution -> Solution
          (define (find-value eq solution)
            (local ((define coefficient (lhs eq))
                    (define constant (rhs eq))
                    (define plugged (plug-in (rest coefficient) solution)))
              (cons (/ (- constant plugged) (first coefficient))
                    solution))))
    (foldr find-value '() matrix)))
;====================================================;
; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(define (lhs e)
  (reverse (rest (reverse e))))
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(define (rhs e)
  (first (reverse e)))

; [List-of Number] Solution -> Number
; calculates out the value of the left-hand side when
; the numbers from the solution are plugged in for
; the variables.
(define (plug-in left-hand solution)
  (foldr (lambda (lh sol re) (+ (* lh sol) re))
         0
         left-hand solution))