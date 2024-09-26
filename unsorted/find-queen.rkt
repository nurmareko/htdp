;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname find-queen) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square
; at the r-th row and c-th column
(define 0-0 (make-posn 0 0))
(define 0-1 (make-posn 0 1))
(define 0-2 (make-posn 0 2))
(define 0-3 (make-posn 0 3))
(define 1-0 (make-posn 1 0))
(define 1-1 (make-posn 1 1))
(define 1-2 (make-posn 1 2))
(define 1-3 (make-posn 1 3))
(define 2-0 (make-posn 2 0))
(define 2-1 (make-posn 2 1))
(define 2-2 (make-posn 2 2))
(define 2-3 (make-posn 2 3))
(define 3-0 (make-posn 3 0))
(define 3-1 (make-posn 3 1))
(define 3-2 (make-posn 3 2))
(define 3-3 (make-posn 3 3))

; A Board is a [List-of Column]
; interpretation:
;   a Board collects those positions where a queen can
;   still be placed.

; A Column is a [List-of [Maybe QP]]
(define BOARD-EMPTY ; an empty 4 by 4  board board.
  (list (list 0-0 0-1 0-2 0-3)
        (list 1-0 1-1 1-2 1-3)
        (list 2-0 2-1 2-2 2-3)
        (list 3-0 3-1 3-2 3-3)))

(define BOARD ; a board with some queens placed
  (list (list 0-0 0-1 #f  0-3)
        (list #f  1-1 1-2 1-3)
        (list 2-0 2-1 2-2 #f )
        (list 3-0 3-1 3-2 3-3)))

; data example: [List-of QP]
(define 4QUEEN-SOLUTION-1
  (list  (make-posn 0 1) (make-posn 1 3)
         (make-posn 2 0) (make-posn 3 2)))
(define 4QUEEN-SOLUTION-2
  (list  (make-posn 0 2) (make-posn 1 0)
         (make-posn 2 3) (make-posn 3 1)))

;====================================================;
; Board -> [List-of QP]
; find all placed queen on a board

(check-expect (all-queen '()) '())
(check-expect (all-queen BOARD-EMPTY) '())
(check-expect (all-queen BOARD) (list 0-2 1-0 2-3))

(define (all-queen a-board)
  (local ((define initial-board a-board))
    (foldr (lambda (col rest)
             (append (find-queen col (column-index col initial-board)) rest))
           '()
           a-board)))

; Column N -> [List-of QP]
; find all placed queen on current column in a board

(check-expect (find-queen '() '()) '())
(check-expect (find-queen (list 3-0 3-1 3-2 3-3) 3) '())
(check-expect (find-queen (list 2-0 2-1 2-2 #f ) 2) (list 2-3))
(check-expect (find-queen (list #f  1-1 1-2 1-3) 1) (list 1-0))
(check-expect (find-queen (list 0-0 0-1 #f  0-3) 0) (list 0-2))

(define (find-queen column column-index)
  (local (; Column N -> [List-of QP]
          (define (find-queen column row-ith)
            (cond
              [(empty? column) '()]
              [else
               (if (boolean? (first column))
                   (cons (make-posn column-index row-ith) (find-queen (rest column) (add1 row-ith)))
                   (find-queen (rest column) (add1 row-ith)))])))
    (find-queen column 0)))
         
; Column Board -> Number
; get the index of a column in a board

(check-expect (column-index (list 0-0 0-1 0-2 0-3) BOARD-EMPTY) 0)
(check-expect (column-index (list 1-0 1-1 1-2 1-3) BOARD-EMPTY) 1)
(check-expect (column-index (list 2-0 2-1 2-2 2-3) BOARD-EMPTY) 2)
(check-expect (column-index (list 3-0 3-1 3-2 3-3) BOARD-EMPTY) 3)

(define (column-index this-column a-board)
  (if (equal? this-column (first a-board))
      0
      (+ 1 (column-index this-column (rest a-board)))))