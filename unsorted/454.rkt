;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |454|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Matrix is a [List-of [List-of Number]]
;====================================================;
; N [List-of Number] -> Matrix
; consumes a number n and a list of n2 numbers. It
; produces an (n * n) image matrix.

(check-expect
 (create-matrix 0 '())
 '())
(check-expect
 (create-matrix 1 '(1))
 '((1)))
(check-expect
 (create-matrix 2 '(1 2 3 4))
 '((1 2)
   (3 4)))
(check-expect
 (create-matrix 3 '(1 2 3 4 5 6 7 8 9))
 '((1 2 3)
   (4 5 6)
   (7 8 9)))

(define (create-matrix n ln)
  (cond
    [(empty? ln) '()]
    [else
     (cons (first-line n ln)
           (create-matrix n (remove-first-line n ln)))]))
;====================================================;
; N [List-of Number] -> [List-of Number]
; get the first n items of ln.

(check-expect (first-line 0 '(1 2 3 4)) '())
(check-expect (first-line 2 '(1 2 3 4)) '(1 2))
(check-expect (first-line 3 '(1 2 3 4 5 6 7 8 9))
              '(1 2 3))

(define (first-line n ln)
  (cond
    [(zero? n) '()]
    [else
     (cons (first ln)
           (first-line (sub1 n) (rest ln)))]))
;====================================================;
; N [List-of Number] -> [List-of Number]
; remove the first n items of ln.

(check-expect (remove-first-line 0 '(1)) '(1))
(check-expect (remove-first-line 2 '(1 2 3 4)) '(3 4))
(check-expect (remove-first-line 3 '(1 2 3 4 5 6 7 8 9))
              '(4 5 6 7 8 9))

(define (remove-first-line n ln)
  (cond
    [(zero? n) ln]
    [else
     (remove-first-line (sub1 n) (rest ln))]))