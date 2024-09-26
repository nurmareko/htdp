;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |412|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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
; adds two Inex representations of numbers that have
; the same exponent.

(check-expect (inex+ (create-inex 10 1 0) (create-inex 25 1 0))
              (make-inex 35 1 0))
(check-expect (inex+ (create-inex 80 1 0) (create-inex 30 1 0))
              (create-inex 11 1 1))
(check-expect (inex+ (create-inex 80 1 0) (create-inex 35 1 0))
              (create-inex 12 1 1))
(check-error (inex+ (create-inex 99 1 99) (create-inex 5 1 99)))

;(define (inex+ a b)
;  (local ((define man-a (inex-mantissa a))
;          (define man-b (inex-mantissa b))
;          (define sign (inex-sign a))
;          (define exp (inex-exponent a))
;          (define added (+ man-a man-b))
;          (define exceed-limit? (if (> added 99) #true #false)))
;    (make-inex (if exceed-limit? (round (/ added 10)) added)
;               sign
;               (if exceed-limit?
;                   (if (> (+ exp 1) 99) (error "exceed 2 digit") (+ exp 1))
;                   exp))))

(define (inex+ a b)
  (local ((define man-a (inex-mantissa a))
          (define man-b (inex-mantissa b))
          (define sign (inex-sign a))
          (define exp (inex-exponent a))
          (define added (+ man-a man-b)))
    (cond
      [(<= added 99) (make-inex added sign exp)]
      [(< exp 99) (make-inex (round (/ added 10)) sign (add1 exp))]
      [else (error "exceed 2 digit")])))

















