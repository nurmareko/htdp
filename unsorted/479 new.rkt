;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |479 new|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at
; the r-th row and c-th column

; QP QP -> Boolean
; are queen-one and queen-two threaten each other?

(check-expect (threatening? (make-posn 0 2) (make-posn 0 0)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 0 1)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 0 2)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 0 3)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 0 2)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 1 2)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 2 2)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 3 2)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 1 1)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 2 0)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 1 3)) #true)
(check-expect (threatening? (make-posn 0 2) (make-posn 1 0)) #false)
(check-expect (threatening? (make-posn 0 2) (make-posn 2 3)) #false)
(check-expect (threatening? (make-posn 0 2) (make-posn 3 1)) #false)

(define (threatening? queen-one queen-two)
  (local ((define x1 (posn-x queen-one))
          (define y1 (posn-y queen-one))
          (define x2 (posn-x queen-two))
          (define y2 (posn-y queen-two)))
    (or (= y1 y2)
        (= x1 x2)
        (= (+ x1 y1) (+ x2 y2))
        (= (- x1 y1) (- x2 y2)))))