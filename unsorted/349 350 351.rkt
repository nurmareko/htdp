;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |349 350 351|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
(define-struct andx [left right])
(define-struct orx [left right])
(define-struct notx [boolean])
(define WRONG "WRONG")
;====================================================;
; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)
	
; An Atom is one of: 
; – Number
; – String
; – Symbol
(define (atom? v)
  (or (number? v) (string? v) (symbol? v)))
;====================================================;
; BSL-expr is one of:
; - Num
; - Add
; - Mul
(define (bsl-expr? v)
  (or (number? v) (add? v) (mul? v)))

; Num is a Number

; Addition is a structure:
;  (make-add BSL-expr BSL-expr)
; Multiplication is a structure:
;  (make-mul BSL-expr BSL-expr)
;====================================================;
; S-expr -> BSL-expr

(check-expect (parse 5) 5)
(check-expect (parse '(+ 1 2)) (make-add 1 2))
(check-expect (parse '(* 2 5)) (make-mul 2 5))
(check-error (parse "5"))
(check-error (parse 'five))
(check-error (parse '(* 2 5 3)))
(check-error (parse '(- 2 5 )))

(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))
 
; SL -> BSL-expr 
(define (parse-sl s)
  (cond
    [(and (consists-of-3 s) (symbol? (first s)))
     (cond
       [(symbol=? (first s) '+)
        (make-add (parse (second s)) (parse (third s)))]
       [(symbol=? (first s) '*)
        (make-mul (parse (second s)) (parse (third s)))]
       [else (error WRONG)])]
    [else (error WRONG)]))
 
; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))
 
; SL -> Boolean
(define (consists-of-3 s)
  (and (cons? s) (cons? (rest s)) (cons? (rest (rest s)))
       (empty? (rest (rest (rest s))))))
;=351================================================;
; S-expr -> Num
; If parse recognizes them as BSL-expr, it produce
; their value. Otherwise, it signals the same error
; as parse.

(check-expect (interpreter-expr 5) 5)
(check-expect (interpreter-expr '(+ 1 2)) 3)
(check-expect (interpreter-expr '(* 2 5)) 10)
(check-error (interpreter-expr "5"))
(check-error (interpreter-expr 'five))
(check-error (interpreter-expr '(* 2 5 3)))
(check-error (interpreter-expr '(- 2 5 )))

(define (interpreter-expr s)
  (eval-expression (parse s)))
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










