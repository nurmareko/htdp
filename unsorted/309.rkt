;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |309|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [List-of [List-of String]] -> [List-of Number]
; determines the number of Strings per item in a list
; of list of strings.

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))

(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1) (cons 2 (cons 0 '())))

(define (words-on-line lls)
  (for/list ([ls lls]) (match ls [l (length l)])))


