;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |506|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X -> Y] [List-of X] -> [List-of Y]
; Constructs a new list by applying 'f' to each item on 'l'

(check-expect (m*p add1 '(1 2 3)) '(2 3 4))
(check-expect (m*p sub1 '(1 2 3)) '(0 1 2))
(check-expect (m*p (lambda (x) x) '(1 2 3)) '(1 2 3))

;(define (my-map f l)
;  (cond
;    [(empty? l) '()]
;    [else
;     (cons (f (first l))
;           (my-map f (rest l)))]))

(define (m*p f l0)
  (local (; [X -> Y] [List-of X] [List-of Y] -> [List-of Y]
          ; Constructs a new list by applying 'f' to each
          ; item on 'l'
          ; accumulator 'a' is the list of the result of
          ; 'f' applied to some item on 'l0' that 'l' lacks
          (define (map/a f l a)
            (cond
              [(empty? l)(reverse a)]
              [else
               (map/a f (rest l)
                      (cons (f (first l)) a))])))
    (map/a f l0 '())))