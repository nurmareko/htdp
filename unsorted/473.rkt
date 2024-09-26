;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |473|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Node is a Symbol.

; A Graph is a [List-of [NEList-of Node]]
; interpretation:
;  each non-empty list of node represent a relation
;  of node with its immediate neighbors.
;  its first item as its name, and
;  the rest represent edges that connect to its
;  neighbors.
(define sample-graph
  '((A B E)
    (B E F)
    (C D  )
    (D    )
    (E C F)
    (F D G)
    (G    )))

(define a-graph
  '((A B)
    (B C)
    (C A)))

(define cyclic-graph
  '((A B E)
    (B E F)
    (C B D)
    (D    )
    (E C F)
    (F D G)
    (G    )))

; A Path is a [List-of Node].
; interpretation The list of nodes specifies a sequence
; of immediate neighbors that leads from the first 
; Node on the list to the last one.

;====================================================;
; Node Graph -> [List-of Node]
; produces the list of immediate neighbors of n in g.
(define (neighbors n g)
  (cond
    [(empty? g) (error "Node not found.")]
    [else
     (if (equal? n (first (first g)))
         (rest (first g))
         (neighbors n (rest g)))]))
 
; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define next (neighbors origination G))
                  (define candidate
                    (find-path/list next destination G)))
            (cond
              [(boolean? candidate) #false]
              [else (cons origination candidate)]))]))
 
; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-Os to D
; if there is no path, the function produces #false
(define (find-path/list lo-Os D G)
  (cond
    [(empty? lo-Os) #false]
    [else (local ((define candidate
                    (find-path (first lo-Os) D G)))
            (cond
              [(boolean? candidate)
               (find-path/list (rest lo-Os) D G)]
              [else candidate]))]))
;====================================================;
; Graph -> Boolean
; is there a path between every pair of nodes?

;(define (test-on-all-nodes graph)
;  (andmap (lambda (r) (not (empty? (rest r)))) graph))

(define (test-on-all-nodes graph)
  (local (; [X Y] [List-of X] [List-of Y] -> [List-of [List X Y]]
          (define (cartesian-product a b)
            (foldr (lambda (x re) (append (map (lambda (y) (list x y)) b) re)) '() a))
          ; [List Node Node] -> Boolean
          (define (path? pair)
            (cons? (find-path (first pair) (second pair) graph)))
          (define nodes (map first graph))
          (define all-pair (cartesian-product nodes nodes)))
    (andmap path? all-pair)))
