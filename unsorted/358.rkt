;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |358|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name argument])
(define-struct def [name parameter body])
(define WRONG "WRONG")
; A BSL-fun-expr is one of: 
; – Number
; - Symbol
; – Add
; – Mul
; - Fun

; Add is a structure
;  (make-add BSL-fun-expr BSL-fun-expr)

; Mul is a structure
;  (make-mul BSL-fun-expr BSL-fun-expr)

; Fun is a structure
;  (make-fun Symbol BSL-fun-expr)

; A BSL-fun-def* is a list:
;  [List-of BSL-fun-def]

; A BSL-fun-def is a structure:
; (make-def [Symbol Symbol BSL-fun-expr]

; A Value is a Number

; BSL-fun-def and BSL-fun-def* examples
(define f (make-def 'f 'x (make-add 3 'x )))
(define g (make-def 'g 'y (make-fun 'f (make-mul 2 'y))))
(define h (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

(define da-fgh (list f g h))
;====================================================;
; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none

(check-expect (lookup-def da-fgh 'f) f)
(check-expect (lookup-def da-fgh 'g) g)
(check-expect (lookup-def da-fgh 'h) h)
(check-error (lookup-def da-fgh 'i) WRONG)

(define (lookup-def da f)
  (cond
    [(empty? da) (error WRONG)]
    [else
     (if (symbol=? f (def-name (first da)))
         (first da)
         (lookup-def (rest da) f))]))
;=359================================================;
; BSL-fun-expr BSL-fun-def* -> Value

(check-expect (eval-function* 5 da-fgh) 5)
;(check-expect (eval-function* (make-add 1 2) da-fgh) 3)
;(check-expect (eval-function* (make-mul 2 3) da-fgh) 6)
;(check-expect (eval-function* (make-fun 'f 5) da-fgh) 8)
;(check-expect (eval-function* (make-fun 'g 5) da-fgh) 13)
;(check-expect (eval-function* (make-fun 'h 5) da-fgh) 21)
(check-error (eval-function* 'five da-fgh) WRONG)
(check-error (eval-function* "5" da-fgh) WRONG)
;(check-error (eval-function* (make-fun 'i 5) da-fgh))

(define (eval-function* ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error WRONG)]
    [(add? ex) (for-add ex da)]
    [(mul? ex) (for-mul ex da)]
    [(fun? ex) ...]
    [else (error WRONG)]))
;====================================================;
; Add BSL-fun-def* -> Value
; evaluate addition expresion.

;(check-expect (for-add (make-add 5 5) da-fgh) 10)
;(check-expect (for-add (make-add 5 (make-add 5 5)) da-fgh) 15)
;(check-expect (for-add (make-add 5 (make-mul 5 5)) da-fgh) 30)
;(check-expect (for-add (make-add 5 (make-fun 'f 5)) da-fgh) 13)
;(check-expect (for-add (make-add 5 (make-fun 'g 5)) da-fgh) 18)
;(check-expect (for-add (make-add 5 (make-fun 'h 5)) da-fgh) 26)
;(check-error (for-add (make-add 5 'five) da-fgh) WRONG)
;(check-error (for-add (make-add 5 (make-fun 'i  5)) da-fgh) WRONG)

(define (for-add ex da)
  (+ (eval-function* (add-left ex) da)
     (eval-function* (add-right ex) da)))
;====================================================;
; Mul BSL-fun-def* -> Value
; evaluate multiplication expression.

;(check-expect (for-mul (make-mul 5 5) da-fgh) 25)
;(check-expect (for-mul (make-mul 5 (make-add 5 5)) da-fgh) 50)
;(check-expect (for-mul (make-mul 5 (make-mul 5 5)) da-fgh) 125)
;(check-expect (for-mul (make-mul 5 (make-fun 'f 5)) da-fgh) 40)
;(check-expect (for-mul (make-mul 5 (make-fun 'g 5)) da-fgh) 65)
;(check-expect (for-mul (make-mul 5 (make-fun 'h 5)) da-fgh) 105)
;(check-error (for-mul (make-mul 5 'five) da-fgh) WRONG)
;(check-error (for-mul (make-mul 5 (make-fun 'i 5)) da-fgh) WRONG)

(define (for-mul ex da)
  (* (eval-function* (mul-left ex) da)
     (eval-function* (mul-right ex) da)))
;===================================================;
; Fun BSL-fun-def* -> Value
; evaluate function application.

;(check-expect (for-fun (make-fun 'f 5) da-fgh) 8)
;(check-expect (for-fun (make-fun 'f (make-add 5 5)) da-fgh) 13)
;(check-expect (for-fun (make-fun 'f (make-mul 5 5)) da-fgh) 28)
;(check-expect (for-fun (make-fun 'f (make-fun 'f 5)) da-fgh) 11)
;(check-expect (for-fun (make-fun 'f (make-fun 'g 5)) da-fgh) 16)
;(check-expect (for-fun (make-fun 'f (make-fun 'h 5)) da-fgh) 24)
;(check-error (for-fun (make-fun 'f 'five) da-fgh) WRONG)
;(check-error (for-fun (make-fun 'f (make-fun 'i 5)) da-fgh) WRONG)
;
;(define (for-fun ex da)
;  (eval-expression
;   (make-fun (fun-name ex)
;             (eval-function* (fun-argument ex) da))))

  
