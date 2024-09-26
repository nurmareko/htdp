;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |404|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [X Y] [X Y -> Boolean] [List-of X] [List-of Y] -> Boolean
; ...

(check-expect (andmap2 = '() '()) #true)
(check-expect (andmap2 = '(1 2) '(1 2)) #true)
(check-expect (andmap2 = '(1 2) '(2 3)) #false)

(define (andmap2 f l-x l-y)
  (cond
    [(empty? l-x) #true]
    [else
     (and (f (first l-x) (first l-y))
          (andmap2 f (rest l-x) (rest l-y)))]))
