;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |290|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define DOT (circle 5 "solid" "red"))

; [X] [List-of X] [list-of X] -> [List-of X]
; append l-a with l-b

(check-expect
 (append-from-fold (list 1 2 3) (list 0 0 0))
 (list 1 2 3 0 0 0))
(check-expect
 (append-from-fold (list 1 0 7) (list "a" "b" "c"))
 (list 1 0 7 "a" "b" "c"))

(define (append-from-fold l-a l-b)
  (foldr (lambda (a b) (cons a b)) l-b l-a))

; [List-of Number] -> Number
; compute the sum of all number on ln

(check-expect (sum (list 40 5)) 45)

(define (sum ln)
  (foldr (lambda (x y) (+ x y)) 0 ln))

;[List-of Number] -> Number
; compute the product of all number on ln

(check-expect (product (list 3 3 3)) (* 3 3 3))

(define (product ln)
  (foldr (lambda (x y) (* x y)) 1 ln))

; [List-of Image] -> Image
; compose l-im horizontally

(check-expect (horizontally (list DOT DOT DOT))
              (beside DOT DOT DOT))

(define (horizontally l-im)
  (foldr (lambda (x y)
           (beside x y)) empty-image l-im))

; [List-of Image] -> Image
; compose l-im vertically

(check-expect (vertically (list DOT DOT DOT))
              (above DOT DOT DOT))

(define (vertically l-im)
  (foldr (lambda (x y)
           (above x y)) empty-image l-im))