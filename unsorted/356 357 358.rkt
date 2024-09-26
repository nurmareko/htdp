;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |356 357 358|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name argument])
(define-struct def [name parameter body])
(define WRONG "WRONG")
; A BSL-fun-expr is one of: 
; – Atom
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expr)

; A BSL-fun-def is a:
; [List-of (make-def [Symbol Symbol BSL-fun-expr]]

; An Atom is one of:
; - Number
; - Symbol
(define (atom? v ) (number? v))

;=356================================================;
;(make-fun 'k (make-add  1 1))
;(make-mul 5 (make-fun 'k (make-add 1 1)))
;(make-mul (make-fun 'i 5) (make-fun 'k (make-add 1 1)))
;=357================================================;
; BSL-fun-expr Symbol Symbol BSL-fun-expr -> Value
; determines the value of ex.

(check-expect (eval-definition1 5 'f 'x 0) 5)
(check-expect (eval-definition1 (make-add 1 2) 'f 'x 0) 3)
(check-expect (eval-definition1 (make-mul 3 4) 'f 'x 0) 12)
(check-expect (eval-definition1 (make-fun 'f 5) 'f 'x 0) 0)
(check-expect (eval-definition1 (make-fun 'f 5) 'f 'x 'x) 5)
(check-expect (eval-definition1 (make-fun 'f 5) 'f 'x (make-add 1 'x)) 6)
(check-error (eval-definition1 'five 'f 'x 0))
(check-error (eval-definition1 (make-fun 'f 5) 'g 'x 0))
(check-error (eval-definition1 "frog" 'g 'x 0))

(define (eval-definition1 ex f x b)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error WRONG)]
    [(add? ex)
     (+ (eval-expression (add-left ex))
        (eval-expression (add-right ex)))]
    [(mul? ex)
     (* (eval-expression (mul-left ex))
        (eval-expression (mul-right ex)))]
    [(fun? ex)
     (if (symbol=? f (fun-name ex))
         (local ((define value
                   (eval-definition1 (fun-argument ex) f x b))
                 (define plugd (subst b x value)))
           (eval-definition1 plugd f x b))
         (error WRONG))]
    [else (error WRONG)]))
;====================================================;
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
               (subst (mul-right ex) x v))]))
;====================================================;
; BSL-expr -> Num
; consumes a representation of a BSL expression and
; computes its value.
(define (eval-expression ex)
  (cond
    [(number? ex) ex]
    [(add? ex)
     (+ (eval-expression (add-left ex))
        (eval-expression (add-right ex)))]
    [(mul? ex)
     (* (eval-expression (mul-left ex))
        (eval-expression (mul-right ex)))]))