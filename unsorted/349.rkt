;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |349|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
