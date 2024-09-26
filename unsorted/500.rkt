;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |500|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of X] -> N
; determine the number of item in alox

(check-expect (how-many '()) 0)
(check-expect (how-many '(a b c)) 3)

(define (how-many alox)
  (cond
    [(empty? alox) 0]
    [else
     (+ 1 (how-many (rest alox)))]))
;====================================================;
; [List-of X] -> N
; determine the number of item in a list

(check-expect (how-many.v2 '()) 0)
(check-expect (how-many.v2 '(a b c)) 3)

(define (how-many.v2 alox0)
  (local (; [List-of X] N -> N
          ; determine the number of item in a list
          ; accumulator 'a' is the count for absence
          ; item on alox from alox0.
          (define (how-many/a alox a)
            (cond
              [(empty? alox) a]
              [else
               (how-many/a (rest alox) (add1 a))])))
    (how-many/a alox0 0)))
;====================================================;
; (how-many '(a b c))
; == (how-many/a '(b c) ... 'a ...)
; == (how-many/a '(c) ... 'a ... 'b ...)
; == (how-many/a '() ... 'a ... 'b ... 'c ...)

; accumulator 'a' is the count for absence item on alox from alox0.

; The performance of product is O(n) where n is the length of the list.
; Does the accumulator version improve on this?

; No, the accumulator version performance also O(n).