;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |348|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct andx [left right])
(define-struct orx [left right])
(define-struct notx [boolean])

; A Bool-expr is one of:
; - Bool
; - Andx
; - Orx
; - Notx

; Bool is one of:
; - #true
; - #false

; Andx is a structure:
;  (make-andx Bool-expr Bool-expr)

; Orx is a structure:
;  (make-orx Bool-expr Bool-expr)

; Notx is a structure:
;  (make-notx Bool-expr)
;====================================================;
; Bool-expr -> Bool
; consumes (representations of) Boolean BSL
; expressions and computes their values.

(check-expect (eval-bx #true) #true)
(check-expect (eval-bx #false) #false)
(check-expect (eval-bx (make-andx #true #true)) #true)
(check-expect (eval-bx (make-andx #false #false)) #false)
(check-expect (eval-bx (make-andx #true #false)) #false)
(check-expect (eval-bx (make-orx #true #true)) #true)
(check-expect (eval-bx (make-orx #false #false)) #false)
(check-expect (eval-bx (make-orx #true #false)) #true)
(check-expect (eval-bx (make-notx #true)) #false)
(check-expect (eval-bx (make-notx #false)) #true)

(define (eval-bx bex)
  (cond
    [(boolean? bex) bex]
    [(andx? bex)
     (and (eval-bx (andx-left bex))
          (eval-bx (andx-right bex)))]
    [(orx? bex)
     (or (eval-bx (orx-left bex))
         (eval-bx (orx-right bex)))]
    [(notx? bex) (not (eval-bx (notx-boolean bex)))]))
