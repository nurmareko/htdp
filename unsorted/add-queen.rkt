;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname add-queen) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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
;====================================================;
; Board QP -> Board 
; places a queen at qp on a-board

(check-expect (add-queen BOARD-EMPTY 0-1)
              (list (list 0-0 #f  0-2 0-3)
                    (list 1-0 1-1 1-2 1-3)
                    (list 2-0 2-1 2-2 2-3)
                    (list 3-0 3-1 3-2 3-3)))
(check-expect (add-queen BOARD 3-1)
              (list (list 0-0 0-1 #f  0-3)
                    (list #f  1-1 1-2 1-3)
                    (list 2-0 2-1 2-2 #f )
                    (list 3-0 #f  3-2 3-3)))

(define (add-queen a-board qp)
  (local (; Columm -> Boolean
          (define (correct-column? this-column)
            (local (; Board -> Number
                    (define (column-index a-board)
                      (if (equal? this-column (first a-board))
                          0
                          (+ 1 (column-index (rest a-board))))))
              (= (column-index a-board) (posn-x qp))))       
          ; Column -> Column
          (define (place-in-column column)
            (map (lambda (item) (if (equal? qp item) #false item)) column)))
    (map (lambda (col)
           (if (correct-column? col)
               (place-in-column col)
               col))
         a-board)))

;====================================================;
;; Columm Board QP -> Boolean
;; is this-column the correct column to place qp in a-board?
;(check-expect
; (correct-column? (list 0-0 0-1 0-2 0-3) 0-1 BOARD-EMPTY)
; #true)
;(check-expect
; (correct-column? (list 1-0 1-1 1-2 1-3) 0-1 BOARD-EMPTY)
; #false)
;(define (correct-column? this-column qp a-board)
;  (= (column-index this-column a-board) (posn-x qp)))
;
;(define (column-index this-column a-board)
;  (foldr (lambda (i re) ...) (error "massage") 
;; Column QP -> Column
;; replace a initial queen position in a column with
;; #false if there such item that equal to qp
;(check-expect (place-in-column 0-0 (list 0-0 0-1 0-2 0-3))
;              (list #f 0-1 0-2 0-3))
;(check-expect (place-in-column 0-1 (list 0-0 0-1 0-2 0-3))
;              (list 0-0 #f 0-2 0-3))
;(check-expect (place-in-column 0-2 (list 0-0 0-1 0-2 0-3))
;              (list 0-0 0-1 #f 0-3))
;(check-expect (place-in-column 0-3 (list 0-0 0-1 0-2 0-3))
;              (list 0-0 0-1 0-2 #f))
;(check-expect (place-in-column 1-1 (list 0-0 0-1 0-2 0-3))
;              (list 0-0 0-1 0-2 0-3))
;(define (place-in-column qp column)
;  (map (lambda (item) (if (equal? qp item) #false item)) column))