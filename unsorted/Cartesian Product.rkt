;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Cartesian Product|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; [X Y] [List-of X] [List-of Y] -> [List-of [List X Y]]
; ...

(check-expect (cartesian-product '() '()) '())
(check-expect (cartesian-product '() '(c d)) '(c d))
(check-expect (cartesian-product '(a b) '()) '(a b))
(check-expect (cartesian-product '(a b) '(c d)) '((a c)(a d)(c a)(c b)))
(check-expect (cartesian-product '(c d) '(a b)) '((c a)(d a)(a c)(b c)))

(define (cartesian-product a b)
  (cond
    [(and (empty? a) (empty? b)) ...]
    [(and (empty? a) (cons? b)) ...]
    [(and (cons? a) (empty? b)) ...]
    [(and (cons? a) (cons? b)) ...]))