;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |513|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct lam [par bod])
(define-struct app [fun arg])
; A Lam is one of:
; - Symbol
; - (make-λ Symbol Lam)
; - (make-app Lam Lam)
(define ex1 (make-lam 'x 'x))
(define ex2 (make-lam 'x 'y))
(define ex3 (make-lam 'y (make-lam 'x 'y)))
;====================================================;
