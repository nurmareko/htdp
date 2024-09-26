;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 483V01) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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

; A Board is a [List-of Row]
; interpretation:
;   a Board collects those positions where a queen can
;   still be placed.

; A Row is a [List-of [Maybe QP]]

(define BOARD0-EMPTY ; an empty 4 by 4  board board.
  (list (list 0-0 1-0 2-0 3-0)
        (list 0-1 1-1 2-1 3-1)
        (list 0-2 1-2 2-2 3-2)
        (list 0-3 1-3 2-3 3-3)))

(define BOARD0 ; a board with one queen placed at (1, 1)
  (list (list 0-0 1-0 2-0 3-0)
        (list 0-1 #f  2-1 3-1)
        (list 0-2 1-2 2-2 3-2)
        (list 0-3 1-3 2-3 3-3)))
;====================================================;
; N -> Board 
; creates the initial n by n board
(define (board0 n) ...)
 
; Board QP -> Board 
; places a queen at qp on a-board
(define (add-queen a-board qp)
  a-board)
 
; Board -> [List-of QP]
; finds spots where it is still safe to place a queen
(define (find-open-spots a-board)
  '())