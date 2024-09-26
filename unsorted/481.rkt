;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |481|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square
; at the r-th row and c-th column

; data example: [List-of QP]
(define 4QUEEN-SOLUTION-1
  (list  (make-posn 0 1) (make-posn 1 3)
         (make-posn 2 0) (make-posn 3 2)))
(define 4QUEEN-SOLUTION-2
  (list  (make-posn 0 2) (make-posn 1 0)
         (make-posn 2 3) (make-posn 3 1)))

;====================================================;
; N -> [Maybe [List-of QP]]
; finds a solution to the n queens problem

(check-satisfied (n-queens 4) is-queens-result?)

(define (n-queens n)
  (place-queens (board0 n) n))

; [List-of QP] -> Boolean
; is the result equal [as a set] to one of two lists

(check-expect (is-queens-result? 4QUEEN-SOLUTION-1) #true)
(check-expect (is-queens-result? 4QUEEN-SOLUTION-2) #true)

(define (is-queens-result? x)
  (or (set=? 4QUEEN-SOLUTION-1 x)
      (set=? 4QUEEN-SOLUTION-2 x)))

; [List-of X] [List-of Y] -> Boolean
; is set-x equal to set-y?

(check-expect (set=? '(a b c) '(a b c)) #true)
(check-expect (set=? '(a b c) '(c b a)) #true)
(check-expect (set=? '(a b c) '(a b c d)) #false)

(define (set=? set-x set-y)
  (local (;[List-of X] -> Boolean
          (define (check set-x)
            (andmap (lambda (item) (member? item set-y)) set-x)))
    (if (= (length set-x) (length set-y))
        (or (equal? set-x set-y) (check set-x))
        #false)))


