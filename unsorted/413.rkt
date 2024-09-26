;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |413|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).
;====================================================;
; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))

(define MAX-POSITIVE (create-inex 99 1 99))
(define MIN-POSITIVE (create-inex 1 -1 99))
 
; Inex -> Number
; converts an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
       10 (* (inex-sign an-inex) (inex-exponent an-inex)))))
;====================================================;
; Inex Inex  -> Inex
; multiple two Inex representations of numbers

(check-expect
 (inex* (create-inex 2 1 4) (create-inex 8 1 10))
 (create-inex 16 1 14))
(check-expect
 (inex* (create-inex 20 1 1) (create-inex 5 1 4))
 (create-inex 10 1 6))
(check-expect
 (inex* (create-inex 27 -1 1) (create-inex 7 1 4))
 (create-inex 19 1 4))
(check-expect
 (inex* (create-inex 2 1 4) (create-inex 8 1 10))
 (create-inex 16 1 14))
(check-expect
 (inex* (create-inex 20 1 1) (create-inex  5 1 4))
 (create-inex 10 1 6))
(check-expect
 (inex* (create-inex 6 -1 3) (create-inex 5 -1 2))
 (create-inex 30 -1 5))
(check-expect
 (inex* (create-inex 27 -1 1) (create-inex  7 1 4))
 (create-inex 19 1 4))
(check-error
 (inex* (create-inex 98 1 50) (create-inex 98 1 98))
 "out of range")
(check-error
 (inex* (create-inex 98 1 98) (create-inex 98 1 98))
 "out of range")

(define (inex* a b)
  (local ((define man-a (inex-mantissa a))
          (define sign-a (inex-sign a))
          (define exp-a (inex-exponent a))
          (define man-b (inex-mantissa b))
          (define sign-b (inex-sign b))
          (define exp-b (inex-exponent b))
          (define man-mul (* man-a man-b))
          (define exp-add (+ (* sign-a exp-a) (* sign-b exp-b)))
          (define sign
            (if (or (positive? exp-add) (zero? exp-add)) 1 -1)))
    (cond
      [(<= man-mul 99) (make-inex man-mul sign (abs exp-add))]
      [(< (abs exp-add) 99) (make-inex (round (/ man-mul 10)) sign (abs (add1 exp-add)))]
      [else (error "out of range")])))
  
















