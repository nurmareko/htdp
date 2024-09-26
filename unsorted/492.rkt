;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |492|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; A Node is a Symbol.

; A Graph is a [List-of [NEList-of Node]]
; interpretation:
;  each non-empty list of node represent a relation
;  of node with its immediate neighbors.
;  its first item as its name, and
;  the rest represent edges that connect to its
;  neighbors.
(define a-sg ; Graph example
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F)))

; A Path is a [List-of Node].
; interpretation The list of nodes specifies a sequence
; of immediate neighbors that leads from the first 
; Node on the list to the last one.

;====================================================;
 
; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false

(check-expect (find-path 'A 'E a-sg) '(A B C E))
(check-expect (find-path 'A 'F a-sg) #false)

(define (find-path origination destination G)
  (local (; Node Node Graph [List-of Node] -> [Maybe Path]
          (define (find-path/a origination destination G seen)
            (cond
              [(symbol=? origination destination) (list destination)]
              [else (local ((define next (neighbors origination G))
                            (define candidate
                              (find-path/list next destination G
                                              (cons origination seen))))
                      (cond
                        [(boolean? candidate) #false]
                        [else (cons origination candidate)]))]))
          ; [List-of Node] Node Graph [List-of Node] -> [Maybe Path]
          (define (find-path/list lo-Os D G seen)
            (cond
              [(empty? lo-Os) #false]
              [(member? (first lo-Os) seen) #false]
              [else (local ((define candidate
                              (find-path/a (first lo-Os) D G seen)))
                      (cond
                        [(boolean? candidate)
                         (find-path/list (rest lo-Os) D G seen)]
                        [else candidate]))]))) 
    (find-path/a origination destination G '())))

; Node Graph -> [List-of Node]
; produces the list of immediate neighbors of n in g.

(define (neighbors n g)
  (cond
    [(empty? g) (error "Node not found.")]
    [else
     (if (equal? n (first (first g)))
         (rest (first g))
         (neighbors n (rest g)))]))