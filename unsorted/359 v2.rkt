;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |359 v2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;===================================================;
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
;=359===============================================;
; BSL-fun-expr BSL-fun-def* -> Value

(check-expect (eval-function* 5 da-fgh) 5)
(check-expect (eval-function* (make-add 1 2) da-fgh) 3)
(check-expect (eval-function* (make-mul 2 3) da-fgh) 6)
(check-expect (eval-function* (make-fun 'f 5) da-fgh) 8)
(check-expect (eval-function* (make-fun 'g 5) da-fgh) 13)
(check-expect (eval-function* (make-fun 'h 5) da-fgh) 21)
(check-error (eval-function* 'five da-fgh) WRONG)
(check-error (eval-function* "5" da-fgh) WRONG)
(check-error (eval-function* (make-fun 'i 5) da-fgh))

(define (eval-function* ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error WRONG)]
    [(add? ex)
     (+ (eval-function* (add-left ex) da)
        (eval-function* (add-right ex) da))]
    [(mul? ex)
     (* (eval-function* (mul-left ex) da)
        (eval-function* (mul-right ex) da))]
    [(fun? ex)
     (local ((define defined (lookup-def da (fun-name ex)))
             (define plugd
               (subst (def-body defined)
                      (def-parameter defined)
                      (fun-argument ex))))
       (eval-function* plugd da))]
    [else (error WRONG)]))
;===================================================;
; BSL-var-expr Symbol Number -> BSL-var-expr
; produces a BSL-var-expr like ex with all
; occurrences of x replaced by v.
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (equal? ex x) v ex)]
    [(add? ex)
     (make-add (subst (add-left ex) x v)
               (subst (add-right ex) x v))]
    [(mul? ex)
     (make-mul (subst (mul-left ex) x v)
               (subst (mul-right ex) x v))]
    [(fun? ex)
     (make-fun (fun-name ex)
               (subst (fun-argument ex) x v))]))
  
