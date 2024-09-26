;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |345|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])

; BSL-expr is one of:
; - Num
; - Add
; - Mul

; Addition is a structure:
;  (make-add BSL-expr BSL-expr)

; Multiplication is a structure:
;  (make-mul BSL-expr BSL-expr)

; Num is a Number
;====================================================;
;(make-add 10 -10)
;
;(make-add (make-mul 20 3) 33)
;
;(make-add (make-mul 3.14 (make-mul 2 3))
;          (make-mul 3.14 (make-mul -1 -9)))
;
;(+ -1 2)
;
;(+ (* -2 -3) 33)
;
;(* (+ 1 (* 2 3)) 3.14)
;====================================================;
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


