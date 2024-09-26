;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |intermezzo 3 cross|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [List-of X] [List-of Y] -> [List-of [List X Y]]
; generates all pairs of items from l1 and l2
 
(check-satisfied (cross0 '(a b c) '(1 2))
                 (lambda (c) (= (length c) 6)))
(check-satisfied (cross0 '() '(1 2))
                 (lambda (c) (= (length c) 0)))
(check-satisfied (cross0 '() '())
                 (lambda (c) (= (length c) 0)))

(define (cross0 l1 l2)
  (cond
    [(empty? l1) '()]
    [else (append (all-pair (first l1) l2)
                  (cross0 (rest l1) l2))]))

; [X Y] X [list-of Y] -> [list of [list X Y]]
; create pairs of x and avery item on l

(check-expect (all-pair "a" '()) '())
(check-expect (all-pair "a" (list 1 2))
              (list (list "a" 1) (list "a" 2)))

(define (all-pair x l)
  (cond
    [(empty? l) '()]
    [else (cons (list x (first l))
                (all-pair x (rest l)))]))
;====================================================;
; [List-of X] [List-of Y] -> [List-of [List X Y]]
; generates all pairs of items from l1 and l2
 
(check-satisfied (cross '(a b c) '(1 2))
                 (lambda (c) (= (length c) 6)))
 
(define (cross l1 l2)
   (for*/list ([x1 l1][x2 l2])
      (list x1 x2)))