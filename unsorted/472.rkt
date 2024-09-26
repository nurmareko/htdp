;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |472|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Graph is [List-of Node-Relation]

; A Path is a [List-of Node].
; interpretation The list of nodes specifies a
; sequence of immediate neighbors that leads from the
; first Node on the list to the last one. 

; A Node-Relation is (list Node [List-of Node])
; - where the first item represent a node, and
; - the second item represent its immediate neighbors.

; A Node is a Symbol.
;====================================================;
(define sample-graph
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
        (list 'C (list 'D))
        (list 'D '())
        (list 'E (list 'C 'F))
        (list 'F (list 'D 'G))
        (list 'G '())))

(define all-have-path
  (list (list 'A (list 'B))
        (list 'B (list 'C))
        (list 'C (list 'A))))

(define cyclic-graph
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
        (list 'C (list 'B 'D))
        (list 'D '())
        (list 'E (list 'C 'F))
        (list 'F (list 'D 'G))
        (list 'G '())))
;====================================================;
; Node Graph -> [List-of Node]
; produces the list of immediate neighbors of n in g.

(check-expect (neighbors 'A sample-graph)
              (list 'B 'E))
(check-expect (neighbors 'D sample-graph)
              '())
(check-error (neighbors 'H sample-graph))

(define (neighbors n g)
  (local ((define found (assq n g)))
    (if (false? found)
        (error "Node not found.")
        (second found))))
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
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define next (neighbors origination G))
                  (define candidate
                    (find-path/list next destination G)))
            (cond
              [(boolean? candidate) #false]
              [else (cons origination candidate)]))]))
;====================================================;
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
; determines whether there is a path between every
; pair of nodes in g.

(check-expect (test-on-all-nodes '()) #true)
(check-expect (test-on-all-nodes '((A (A)))) #true)
(check-expect (test-on-all-nodes '((A (B)) (B (B)))) #true)
(check-expect (test-on-all-nodes all-have-path) #true)
(check-expect (test-on-all-nodes sample-graph) #false)
(check-expect (test-on-all-nodes '((A (B)) (B (B C)) (C ()))) #false)

;(define (test-on-all-nodes g)
;  (cond
;    [(empty? g) #true]
;    [else
;     (if (empty? (second (first g)))
;         #false
;         (test-on-all-nodes (rest g)))]))

(define (test-on-all-nodes g)
  (andmap (lambda (x) (not (empty? (second x)))) g))
;===================================================;

