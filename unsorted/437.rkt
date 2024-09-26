;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |437|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; [X] [List-of X] -> Number
;; computes the length of P
;
;(check-expect (special '()) 0)
;(check-expect (special '(1 2)) 2)
;
;(define (special P)
;  (cond
;    [(empty? P) (solve P)]
;    [else
;     (combine-solutions
;       P
;       (special (rest P)))]))
;
;; [X] X -> Number
;(define (solve x) 0)
;
;; [X] X X -> Number
;(define (combine-solutions a b)
;  (+ 1 b))
;===================================================;
;; [List-of Number] -> Number
;; computes the length of P
;
;(check-expect (special '()) '())
;(check-expect (special '(1 2)) '(-1 -2))
;
;(define (special P)
;  (cond
;    [(empty? P) (solve P)]
;    [else
;     (combine-solutions
;       P
;       (special (rest P)))]))
;
;; [X] X -> Number
;(define (solve x) '())
;
;; [X] X X -> Number
;(define (combine-solutions a b)
;  (cons (- (first a) (* (first a) 2)) b))
;===================================================;
;; [List-of String] -> [List-of String]
;; computes the length of P
;
;(check-expect (special '()) '())
;(check-expect (special '("a" "b")) '("A" "B"))
;
;(define (special P)
;  (cond
;    [(empty? P) (solve P)]
;    [else
;     (combine-solutions
;       P
;       (special (rest P)))]))
;
;; [X] X -> Number
;(define (solve x) '())
;
;; [X] X X -> Number
;(define (combine-solutions a b)
;  (cons (string-upcase (first a)) b))

