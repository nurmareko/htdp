;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |361 v2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name argument])
(define-struct def [name parameter body])
(define-struct con [name body])
(define WRONG "WRONG")
; A BSL-expr is one of: 
; – Number
; - Symbol
; – Add
; – Mul
; - Fun

; A BSL-da-all is a list
;  [list-of Def]

; A Def is one of:
; - Fun-def
; - Con-def

; Add is a structure
;  (make-add BSL-expr BSL-expr)
; Mul is a structure
;  (make-mul BSL-expr BSL-expr)
; Fun is a structure
;  (make-fun Symbol BSL-expr)
; A Fun-def is a structure
;  (make-def [Symbol Symbol BSL-expr])
; A Con-def is a structure
;  (make-con [Symbol BSL-expr]
;====================================================;
(define con0
  (make-con 'close-to-pi 3.14))
(define def0
  (make-def 'area-of-circle 'r
            (make-mul 'close-to-pi (make-mul 'r 'r))))
(define def1
  (make-def 'volume-of-10-cylinder 'r
            (make-mul 10 (make-fun 'area-of-circle 'r))))
(define f (make-def 'f 'x (make-add 3 'x )))
(define g (make-def 'g 'y (make-fun 'f (make-mul 2 'y))))
(define h (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

(define da-all (list con0 def0 def1 f g h))
;====================================================;
; BSL-da-all Symbol -> Con-def
; produces the representation of a constant definition
; whose name is x, if such a piece of data exists
; in da.

(check-expect (lookup-con-def da-all 'close-to-pi) con0)
(check-error (lookup-con-def empty 'close-to-pi) WRONG)
(check-error (lookup-con-def da-all 'area-of-circle) WRONG)
(check-error (lookup-con-def da-all 'volume-of-10-cylinder) WRONG)

(define (lookup-con-def da x)
  (if (empty? da)
      (error WRONG)
      (if (and (con? (first da))
               (symbol=? x (con-name (first da))))
          (first da)
          (lookup-con-def (rest da) x))))
;====================================================;
; BSL-da-all Symbol -> Fun-def
; produces the representation of a constant definition
; whose name is x, if such a piece of data exists
; in da.

(check-expect (lookup-fun-def da-all 'area-of-circle) def0)
(check-expect (lookup-fun-def da-all 'volume-of-10-cylinder) def1)
(check-error (lookup-fun-def da-all 'close-to-pi) WRONG)
(check-error (lookup-fun-def empty 'area-of-circle) WRONG)

(define (lookup-fun-def da x)
  (if (empty? da)
      (error WRONG)
      (if (and (def? (first da))
               (symbol=? x (def-name (first da))))
          (first da)
          (lookup-fun-def (rest da) x))))
;=361================================================;
; BSL-expr BSL-da-all -> Number
; evaluate given expression value.

(check-expect (eval-all 5 da-all) 5)
(check-error (eval-all "5" da-all) WRONG)
(check-expect (eval-all 'close-to-pi da-all) 3.14)
(check-error (eval-all 'five da-all) WRONG)
(check-expect (eval-all (make-add 5 5) da-all) 10)
(check-error (eval-all (make-add 5 "5") da-all) WRONG)
(check-expect (eval-all (make-add 5 'close-to-pi) da-all) 8.14)
(check-error (eval-all (make-add 5 'five) da-all) WRONG)
(check-expect (eval-all (make-add 5 (make-add 5 5)) da-all) 15)
(check-expect (eval-all (make-add 5 (make-mul 5 5)) da-all) 30)
(check-expect (eval-all (make-mul 5 5) da-all) 25)
(check-error (eval-all (make-mul 5 "5") da-all) WRONG)
(check-expect (eval-all (make-mul 5 'close-to-pi) da-all) 15.7)
(check-error (eval-all (make-mul 5 'five) da-all) WRONG)
(check-expect (eval-all (make-mul 5 (make-add 5 5)) da-all) 50)
(check-expect (eval-all (make-mul 5 (make-mul 5 5)) da-all) 125)
(check-expect (eval-all (make-fun 'area-of-circle 5) da-all) 78.5)
(check-expect (eval-all (make-fun 'volume-of-10-cylinder 5) da-all) 785)
(check-error (eval-all (make-fun 'i 5) da-all) WRONG)

(define (eval-all ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex)
     (local ((define defined (lookup-con-def da ex))
             (define subst (con-body defined)))
       (eval-all subst da))]
    [(add? ex)
     (+ (eval-all (add-left ex) da)
        (eval-all (add-right ex) da))]
    [(mul? ex)
     (* (eval-all (mul-left ex) da)
        (eval-all (mul-right ex) da))]
    [(fun? ex)
     (local ((define defined (lookup-fun-def da (fun-name ex)))
             (define plugd
               (subst (def-body defined)
                      (def-parameter defined)
                      (fun-argument ex))))
       (eval-all plugd da))]
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