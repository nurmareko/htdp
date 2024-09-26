;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |project n-queen|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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
(define BOARD-NO-SPOT
  (list (list #f  0-1 0-2 0-3)
        (list 1-0 1-1 #f  1-3)
        (list 2-0 2-1 2-2 2-3)
        (list 3-0 #f  3-2 3-3)))
(check-expect (place-queens BOARD-NO-SPOT 1)
              #false)
(check-expect (place-queens BOARD-EMPTY 3)
              (list 0-0 1-2 3-1))

(define (place-queens a-board n)
  (local ((define spots (find-open-spots a-board))
          ; Board N -> [Maybe [List-of QP]]
          (define (place a-board n)
            (cond
              [(zero? n) (all-queen a-board)]
              [else
               (if (empty? open-spots)
                   #false
                   (place (add-queen a-board (first open-spots)) (sub1 n)))])))
    (place a-board n (first spots))))



;====================================================;
; N -> Board 
; creates the initial n by n board
(define (board0 n) ...)
 
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
  (local (
          (define queen-x (posn-x qp))
          (define queen-y (posn-y qp))
          (define board-length (length a-board))
          ; Board -> Board
          (define (add-queen a-board)
            (cond
              [(empty? a-board) '()]
              [else
               (local (
                       (define current-row (- board-length 1 (length (rest a-board))))
                       )
                 (cons (if (= current-row queen-x)
                           (place-queen (first a-board) queen-y)
                           (first a-board))
                       (add-queen (rest a-board))))]))
          )
    (add-queen a-board)))

; Column N -> Column
; ...

(check-expect (place-queen (list 0-0 0-1 0-2 0-3) 1)
              (list 0-0 #f 0-2 0-3))

(define (place-queen column n)
  (cond
    [(empty? column) '()]
    [else
     (cons (if (= (posn-y (first column)) n)
               #false
               (first column))
           (place-queen (rest column) n))]))
 
; Board -> [List-of QP]
; find all placed queen

;(check-expect (all-queen BOARD-EMPTY) '())
;(check-expect (all-queen BOARD) (list 0-2 1-0 2-3))

(define (all-queen a-board)
  (local (
          ; Board N -> [List-of QP]
          (define (all-queen a-board n)
            (cond
              [(empty? a-board) '()]
              [else
               (append (find-queen 0 (first a-board) n)
                       (all-queen (rest a-board) (add1 n)))]))
          )
    (all-queen a-board 0)))

; Column N N -> [LIst-of QP]
; find queens on i-th column

;(check-expect (find-queen 0 (list 0-0 0-1 #f  0-3) 0)
;              (list 0-2))
;(check-expect (find-queen 0 (list 0-0 0-1 #f  #f) 0)
;              (list 0-2 0-3))
;(check-expect (find-queen 0 (list #f #f #f #f) 0)
;              (list 0-0 0-1 0-2 0-3))

(define (find-queen ith column row)
  (cond
    [(empty? column) '()]
    [else
     (if (boolean? (first column))
         (cons (make-posn row ith) (find-queen (+ ith 1) (rest column) row))
         (find-queen (add1 ith) (rest column) row))]))

; Board -> [List-of QP]
; finds spots where it is still safe to place a queen

(check-expect (find-open-spots BOARD)
              (list 3-1))
(check-expect (find-open-spots BOARD-EMPTY)
              (list  0-0 0-1 0-2 0-3
                     1-0 1-1 1-2 1-3
                     2-0 2-1 2-2 2-3
                     3-0 3-1 3-2 3-3))
(check-expect
 (find-open-spots
  (list (list 0-0 0-1 #f  0-3)
        (list #f  1-1 1-2 1-3)
        (list 2-0 2-1 2-2 #f )
        (list 3-0 #f  3-2 3-3)))
 '())

(define (find-open-spots a-board)
  (local (
          (define queens (all-queen a-board))
          ; Board -> [List-of QP]
          (define (find-open-spots a-board)
            (cond
              [(empty? a-board) '()]
              [else
               (append (find-safe (first a-board) queens)
                       (find-open-spots (rest a-board)))]))
          )
  (find-open-spots a-board)))

; Column [List-of QP] -> [List-of QP]
; ...

(check-expect (find-safe (list 0-0 0-1 #f  0-3) (list 0-2 1-0 2-3)) '())
(check-expect (find-safe (list #f  1-1 1-2 1-3) (list 0-2 1-0 2-3)) '())
(check-expect (find-safe (list 2-0 2-1 2-2 #f ) (list 0-2 1-0 2-3)) '())
(check-expect (find-safe (list 3-0 3-1 3-2 3-3) (list 0-2 1-0 2-3)) (list 3-1))

(define (find-safe column queens)
  (cond
    [(member? #f column) '()]
    [(empty? column) '()]
    [else
     (if (safe? (first column) queens)
         (cons (first column) (find-safe (rest column) queens))      
         (find-safe (rest column) queens))]))

; QP [List-of QP] -> Boolean
; is a-qp not threatened by queens?

(check-expect (safe? 3-1 (list 0-2 1-0 2-3)) #true)
(check-expect (safe? 3-3 (list 0-2 1-0 2-3)) #false)

(define (safe? a-qp queens)
  (cond
    [(empty? queens) #true]
    [else
     (and (not (threatening? (first queens) a-qp))
          (safe? a-qp (rest queens)))]))

; QP QP -> Boolean
; are queen-one and queen-two threaten each other?
(define (threatening? queen-one queen-two)
  (local ((define x1 (posn-x queen-one))
          (define y1 (posn-y queen-one))
          (define x2 (posn-x queen-two))
          (define y2 (posn-y queen-two)))
    (or (= y1 y2)
        (= x1 x2)
        (= (+ x1 y1) (+ x2 y2))
        (= (- x1 y1) (- x2 y2)))))