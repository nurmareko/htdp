;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname place-queens) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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
; Board N -> [Maybe [List-of QP]]
; places n queens on board; otherwise, returns #false

(check-expect (place-queens BOARD-EMPTY 0)
              '())
(check-expect (place-queens BOARD 0)
              (list 0-2 1-0 2-3))
(check-expect (place-queens BOARD-EMPTY 1)
              (list 0-0))
(check-expect (place-queens BOARD-EMPTY 4)
              (list 0-1 1-3 2-0 3-2))

(define (place-queens a-board n)
  (local (; [List-of QP] N Board -> [List-of [Maybe QP]]
          (define (find-pattern spots n a-board)
            (foldr (lambda (qp rest)
                     (local ((define candidate (place-queens (add-queen a-board qp) (sub1 n))))
                       (if (boolean? candidate) rest candidate)))
                   #false
                   spots))
          ; Board N -> [Maybe [List-of QP]]
          (define (place-queens a-board n)
            (cond
              [(zero? n) (all-queen a-board)]
              [else
               (local ((define spots (find-open-spots a-board))
                       (define candidate (find-pattern spots n a-board)))
                 (if (boolean? candidate) #false candidate))])))
    (place-queens a-board n)))
;====================================================;
; N -> Board 
; creates the initial n by n board
(define (board0 n)
  (local ( ; N -> [List-of QP]
          (define (create-column i)
            (build-list n (lambda (x) (make-posn i x)))))
  (build-list n create-column)))
;====================================================;
(define (add-queen a-board qp)
  (local (; Columm -> Boolean
          (define (correct-column? this-column)
              (= (column-index this-column a-board) (posn-x qp)))       
          ; Column -> Column
          (define (place-in-column column)
            (map (lambda (item) (if (equal? qp item) #false item)) column)))
    (map (lambda (col)
           (if (correct-column? col)
               (place-in-column col)
               col))
         a-board)))
;====================================================;
; Board -> [List-of QP]
; finds spots where it is still safe to place a queen
(define (find-open-spots a-board)
  (local ((define queens (all-queen a-board))
          ; Column [List-of QP] -> [List-of QP]
          (define (safe-spots column queens)
            (cond
              [(member? #f column) '()]
              [(empty? column) '()]
              [else
               (if (not-safe? (first column) queens)
                   (safe-spots (rest column) queens)
                   (cons (first column)
                         (safe-spots (rest column) queens)))]))
          ; QP [List-of QP] -> Boolean
          (define (not-safe? a-qp queens)
            (local (; QP -> Boolean
                    (define (threatening? queen-one)
                      (local ((define x1 (posn-x queen-one))
                              (define y1 (posn-y queen-one))
                              (define x2 (posn-x a-qp))
                              (define y2 (posn-y a-qp)))
                        (or (= y1 y2)
                            (= x1 x2)
                            (= (+ x1 y1) (+ x2 y2))
                            (= (- x1 y1) (- x2 y2))))))
              (ormap threatening? queens))))
    (foldr (lambda (col rest)
             (append (safe-spots col queens) rest))
           '()
           a-board)))
;====================================================;
; Board -> [List-of QP]
; find all placed queen
(define (all-queen a-board)
  (local ((define initial-board a-board))
    (foldr (lambda (col rest)
             (append (find-queen col (column-index col initial-board)) rest))
           '()
           a-board)))

; Column N N -> [LIst-of QP]
; find queens on i-th column
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
(define (column-index this-column a-board)
  (if (equal? this-column (first a-board))
      0
      (+ 1 (column-index this-column (rest a-board)))))