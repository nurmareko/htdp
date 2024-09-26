;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |504|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> Number
; consumes a list of digits and produces the
; corresponding number. The first item on the list is
; the most significant digit. Hence, when applied to
; '(1 0 2), it produces 102.

(check-expect (to10 '()) 0)
(check-expect (to10 '(7)) 7)
(check-expect (to10 '(5 1)) 51)
(check-expect (to10 '(1 0 2)) 102)

(define (to10 alon)
  (local ((define size (sub1 (length alon)))
          ; [List-of Number] Number -> Number
          ; ...
          (define (to10 alon s)
            (cond
              [(empty? alon) 0]
              [else
               (+ (* (first alon) (expt 10 s))
                  (to10 (rest alon) (sub1 s)))])))
    (to10 alon size)))
;====================================================;
; [List-of Number] -> Number
; consumes a list of digits and produces the
; corresponding number. The first item on the list is
; the most significant digit. Hence, when applied to
; '(1 0 2), it produces 102.

(check-expect (to10.v2 '()) 0)
(check-expect (to10.v2 '(7)) 7)
(check-expect (to10.v2 '(5 1)) 51)
(check-expect (to10.v2 '(1 0 2)) 102)

(define (to10.v2 alon0)
  (local (; [List-of Number] Number N -> Number
          ; ...
          ; accumulator 'a' is the combination of
          ; (n * 10^p) to all preceding number on
          ; alon0 that lacks in alon.
          ; accumulator 'p' the current length of alon
          (define (to10/a alon p a)
            (cond
              [(empty? alon) a]
              [else
               (to10/a (rest alon) (sub1 p)
                       (+ (* (first alon) (expt 10 p)) a))])))
    (to10/a alon0 (sub1 (length alon0)) 0)))
