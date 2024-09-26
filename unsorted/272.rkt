;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |272|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
;; [List-of X] [List-of X] -> [List-of X]
;
;(check-expect
; (append-from-fold (list 1 2 3) (list 8 8 8))
; (list 1 2 3 8 8 8))
;
;(define (append-from-fold a b)
;  (foldr cons b a))
;
;; [List-of Number] -> Number
;
;(check-expect (sum (list 1 2 3)) 6)
;
;(define (sum l)
;  (foldr + 0 l))
;
;; [List-of Number] -> Number
;
;(check-expect (product (list 5 5 2)) 50)
;
;(define (product l)
;  (foldr * 1 l))
;====================================================;
(define DOT (circle 5 "solid" "red"))
(define DOTS (list DOT DOT DOT DOT DOT))

; [List-of Image] -> Image
; horizontally composes a list of Images.
(define (horizontally l)
  (foldl beside empty-image l))

; [List-of Image] -> Image
; vertically composes a list of Images.
(define (vertically l)
  (foldl above empty-image l))


















