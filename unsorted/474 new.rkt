;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |474 new|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false

(check-expect (find-path 'C 'D sample-graph)
              '(C D))
(check-member-of (find-path 'E 'D sample-graph)
                 '(E F D) '(E C D))
(check-expect (find-path 'C 'G sample-graph)
              #false)
(check-member-of (find-path 'A 'G sample-graph)
                 '(A B E F G) '(A B F G) '(A E F G))

(define (find-path origination destination G)
  (local (; Node -> [Maybe Path]
          (define (find-path origination)
            (cond
              [(symbol=? origination destination) (list destination)]
              [else
               (local ((define next (neighbors origination G))
                       (define candidate (find-path/list next)))
                 (if (boolean? candidate)
                     #false
                     (cons origination candidate)))]))
          ; [List-of Node] -> [Maybe Path]
          (define (find-path/list lo-Os)
            (cond
              [(empty? lo-Os) #false]
              [else
               (local ((define candidate (find-path (first lo-Os))))
                 (if (boolean? candidate)
                     (find-path/list (rest lo-Os))
                     candidate))])))
    (find-path origination)))

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
