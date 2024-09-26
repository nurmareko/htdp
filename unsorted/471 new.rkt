;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |471 new|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Node is a Symbol.

; A Graph is a [List-of [NEList-of Node]]
; interpretation:
;  each non-empty list of node represent a relation
;  of node with its immediate neighbors.
;  its first item as its name, and
;  the rest represent edges that connect to its
;  neighbors.
(define sample-graph
  (list (list 'A 'B 'E)
        (list 'B 'E 'F)
        (list 'C 'D   )
        (list 'D      )
        (list 'E 'C 'F)
        (list 'F 'D 'G)
        (list 'G      )))

;====================================================;
; Node Graph -> [List-of Node]
; produces the list of immediate neighbors of n in g.

(check-expect (neighbors 'A sample-graph) '(B E))
(check-expect (neighbors 'C sample-graph) '(D))
(check-expect (neighbors 'G sample-graph) '())
(check-error (neighbors 'H sample-graph))

(define (neighbors n g)
  (cond
    [(empty? g) (error "Node not found.")]
    [else
     (if (equal? n (first (first g)))
         (rest (first g))
         (neighbors n (rest g)))]))
