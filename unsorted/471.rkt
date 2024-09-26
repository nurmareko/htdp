;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |471|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Graph is [List-of Node-Relation]

; A Node-Relation is (list Node [List-of Node])
; - where the first item represent a node, and
; - the second item represent its immediate neighbors.

; A Node is a Symbol.
;====================================================;
(define sample-graph
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
        (list 'C (list 'D))
        (list 'D (list))
        (list 'E (list 'C 'F))
        (list 'F (list 'D 'G))
        (list 'G (list))))
;====================================================;
; Node Graph -> [List-of Node]
; produces the list of immediate neighbors of n in g.

(check-expect (neighbors 'A sample-graph)
              (list 'B 'E))
(check-expect (neighbors 'D sample-graph)
              '())
(check-error (neighbors 'H sample-graph))

(define (neighbors n g)
  (cond
    [(empty? g) (error "Node not found.")]
    [else
     (if (symbol=? n (first (first g)))
         (second (first g))
         (neighbors n (rest g)))]))

;(define (neighbors n g)
;  (local ((define found (assq n g)))
;    (if (false? found)
;        (error "Node not found.")
;        (second found))))