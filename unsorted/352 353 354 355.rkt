;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |352 353 354 355|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
(define WRONG "WRONG")
; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).
;=352================================================;
; BSL-var-expr Symbol Number -> BSL-var-expr
; produces a BSL-var-expr like ex with all
; occurrences of x replaced by v.

(check-expect (subst 0 'x 5) 0)
(check-expect (subst 'x 'x 5) 5)
(check-expect (subst 'y 'x 5) 'y)
(check-expect (subst (make-add 'x 'x) 'x 5) (make-add 5 5))
(check-expect (subst (make-mul 'x 'y) 'x 5) (make-mul 5 'y))

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
;=353=================================================;
; BSL-var-expr -> Boolean
; is the given BSL-var-expr is also a BSL-expr?

(check-expect (numeric? 0) #true)
(check-expect (numeric? 'zero) #false)
(check-expect (numeric? (make-add 1 2)) #true)
(check-expect (numeric? (make-mul '1 'x)) #false)
(check-expect (numeric? "3") #false)

(define (numeric? ex)
  (cond
    [(number? ex) #true]
    [(add? ex)
     (and (numeric? (add-left ex))
          (numeric? (add-right ex)))]
    [(mul? ex)
     (and (numeric? (mul-left ex))
          (numeric? (mul-right ex)))]
    [else #false]))
;=354=================================================;
; BSL-var-expr -> Number

(check-expect (eval-variable 0) 0)
(check-error (eval-variable 'zero))
(check-error (eval-variable "0"))
(check-expect (eval-variable (make-add 1 2)) 3)
(check-error (eval-variable (make-add 1 'x)))
(check-expect (eval-variable (make-mul 2 3)) 6)
(check-error (eval-variable (make-mul 2 'x)))

(define (eval-variable ex)
  (cond
    [(numeric? ex) (eval-expression ex)]
    [else (error WRONG)]))
;===================================================;
; BSL-expr -> Num
; consumes a representation of a BSL expression and
; computes its value.

(check-expect (eval-expression 9) 9)
(check-expect (eval-expression (make-add 10 3)) 13)
(check-expect (eval-expression (make-add 10 (make-mul 2 4))) 18)
(check-expect (eval-expression (make-mul 5 2)) 10)
(check-expect (eval-expression (make-mul 5 (make-add 1 2))) 15)

(define (eval-expression be)
  (cond
    [(number? be) be]
    [(add? be)
     (+ (eval-expression (add-left be))
        (eval-expression (add-right be)))]
    [(mul? be)
     (* (eval-expression (mul-left be))
        (eval-expression (mul-right be)))]))
;=354===============================================;
; BSL-var-expr AL -> Num

(check-expect (eval-variable* 5 '()) 5)
(check-expect (eval-variable* 5 '((x 1))) 5)
(check-expect (eval-variable* 'a '((a 1))) 1)
(check-error (eval-variable* 'a '((b 1))))
(check-error (eval-variable* "a" '((a 1))))
(check-expect (eval-variable* (make-add 1 2) '()) 3)
(check-expect (eval-variable* (make-add 1 2) '((x 5))) 3)
(check-expect (eval-variable* (make-add 1 'x) '((x 5))) 6)
(check-error (eval-variable* (make-add 1 'y) '((x 5))))
(check-expect (eval-variable* (make-mul 2 3) '()) 6)
(check-expect (eval-variable* (make-mul 'x 'y) '((x 3)(y 5))) 15)

;(define (eval-variable* ex da)
;  (local ((define substituted
;            (foldr (lambda (assoc expr)
;                     (subst expr (first assoc) (second assoc)))
;                   ex da)))
;    (eval-variable substituted)))

(define (eval-variable* ex da)
  (cond
    [(empty? da) (eval-expression ex)]
    [else
     (local ((define substituted
               (local ((define x (first (first da)))
                       (define v (second (first da))))
                 (subst ex x v))))
       (if (numeric? substituted)
           (eval-expression substituted)
           (eval-variable* substituted (rest da))))]))
;=355===============================================;
; BSL-var-expr AL -> Number

(check-expect (eval-var-lookup 5 '()) 5)
(check-expect (eval-var-lookup 5 '((x 1))) 5)
(check-expect (eval-var-lookup 'a '((a 1))) 1)
(check-error (eval-var-lookup 'a '((b 1))))
(check-error (eval-var-lookup "a" '((a 1))))
(check-expect (eval-var-lookup (make-add 1 2) '()) 3)
(check-expect (eval-var-lookup (make-add 1 2) '((x 5))) 3)
(check-expect (eval-var-lookup (make-add 1 'x) '((x 5))) 6)
(check-error (eval-var-lookup (make-add 1 'y) '((x 5))))
(check-expect (eval-var-lookup (make-mul 2 3) '()) 6)
(check-expect (eval-var-lookup (make-mul 'x 'y) '((x 3)(y 5))) 15)

(define (eval-var-lookup e da)
  (cond
    [(number? e) e]
    [(symbol? e)
     (if (not (false? (assq e da)))
         (second (assq e da))
         (error WRONG))]
    [(add? e)
     (eval-expression
      (make-add (eval-var-lookup (add-left e) da)
                (eval-var-lookup (add-right e) da)))]
    [(mul? e)
     (eval-expression
      (make-mul (eval-var-lookup (mul-left e) da)
                (eval-var-lookup (mul-right e) da)))]
    [else (error WRONG)]))








