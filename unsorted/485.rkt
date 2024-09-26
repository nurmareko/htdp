;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |485|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; a Tree is one of:
; - Number
; - (list Tree Tree)

; example:
(define ex0 5) ; one node, no recursion
(define ex1 (list 1 2)) ; three node, ...
(define ex2 (list 1 (list 2 3))) ; five node, ...
(define ex3 (list (list 1 2) (list 3 4))); seven node, ...

; Tree -> Number
; determines the sum of the numbers in a tree

(check-expect (sum-tree ex0) 5)
(check-expect (sum-tree ex1) 3)
(check-expect (sum-tree ex2) 6)
(check-expect (sum-tree ex3) 10)
(check-expect (sum-tree ex-worse) 28)
(check-expect (sum-tree ex-best) 28)

(define (sum-tree a-tree)
  (cond
    [(number? a-tree) a-tree]
    [else
     (+ (sum-tree (first a-tree))
        (sum-tree (second a-tree)))]))

; sum-tree run at the order of n steps, where n is
; the number of node in a tree.

; the acceptable measure of the size could be the
; number of nodes it contains.

; the worse tree shape will be a tree that only brach
; on one of the node
(define ex-worse
  (list 5 (list 5 (list 5 3))))

; the best tree shape will be a tree where the left
; and right node are balance
(define ex-best
  (list (list 5 5) (list 5 3)))

