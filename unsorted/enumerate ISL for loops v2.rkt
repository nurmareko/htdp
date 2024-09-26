;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |enumerate ISL for loops v2|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [X] [List-of X] -> [List-of [List N X]]
; produces a list of the same items paired with
; their relative index

(check-expect (enumerate '()) '())
(check-expect (enumerate '(a)) '((0 a)))
(check-expect (enumerate '(a b c)) '((0 a) (1 b) (2 c)))

(define (enumerate lx)
  (for/list ([x lx] [ith (in-naturals 0)])
    (list ith x)))

;(define (enumerate l)
;  (local ((define ith (build-list (length l) (lambda (i) i))))
;    (map list ith l)))

;(define (enumerate l)
;  (local ((define ith 0)
;          (define (enumerate l n)
;            (cond
;              [(empty? l) '()]
;              [else
;               (cons (list n (first l))
;                     (enumerate (rest l) (add1 n)))])))
;    (enumerate l ith)))

;(define (enumerate l)
;  (cond
;    [(empty? l) ...]
;    [else
;     (... (first l) ...
;      ... (enumerate (rest l) ...))]))