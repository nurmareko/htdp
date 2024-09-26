;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |394|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; produces a single sorted list of numbers that
; contains all the numbers on both inputs lists.

(check-expect (merge '() '()) '())
(check-expect (merge '() '(2)) '(2))
(check-expect (merge '(1) '()) '(1))
(check-expect (merge '(1) '(2)) '(1 2))
(check-expect (merge '(2 3) '(1 2)) '(1 2 2 3))

(define (merge a b)
  (cond
    [(empty? a) b]
    [(empty? b) a]
    [else
     (local ((define fa (first a))
             (define fb (first b)))
       (if (< fa fb)
           (cons fa (merge (rest a) b))
           (cons fb (merge a (rest b)))))]))

;(define (merge a b)
;  (cond
;    [(and (empty? a) (empty? b))
;     '()]
;    [(and (empty? a) (cons? b))
;     b]
;    [(and (cons? a) (empty? b))
;     a]
;    [(and (cons? a) (cons? b))
;     (if (< (first a) (first b))
;         (cons (first a) (merge (rest a) b))
;         (cons (first b) (merge a (rest b))))]))

;(define (merge a b)
;  (cond
;    [(and (empty? a) (empty? b))
;     ...]
;    [(and (empty? a) (cons? b))
;     ...]
;    [(and (cons? a) (empty? b))
;     ...]
;    [(and (cons? a) (cons? b))
;     ...]))