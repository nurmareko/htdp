;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |binary search tree|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

; A BST (short for binarySearchTree)
; is a BT according to the following conditions:
; – NONE
; – (make-node ssn0 name0 L R) is a BST if:
;   - L is a BST,
;   - R is a BST,
;   - all ssn fields in L are smaller than ssn0,
;   - all ssn fields in R are larger than ssn0.

; binary search tree examples
(define n10 (make-node 10 'h NONE NONE))
(define n24 (make-node 24 'i NONE NONE))
(define n99 (make-node 99 'o NONE NONE))
(define n15 (make-node 15 'd n10 n24))
(define n77 (make-node 77 'l NONE NONE))
(define n95 (make-node 95 'g NONE n99))
(define n29 (make-node 29 'b n15 NONE))
(define n89 (make-node 89 'c n77 n95))
(define n63 (make-node 63 'a n29 n89))
; not binary search tree examples
(define n3 (make-node 3 'c NONE NONE))
(define n2 (make-node 2 'b NONE NONE))
(define n1 (make-node 1 'a n3 n2))
;=322================================================;
; Number BT -> Boolean
; is bt contains ssn, n?

(check-expect (contains-bt? NONE 10) #false)
(check-expect (contains-bt? n63 10) #true)
(check-expect (contains-bt? n89 10) #false)

;(define (f n v)
;  (cond
;    [(no-info? v) ...]
;    [else
;     (... (node-ssn v) ...
;      ... (node-name v) ...
;      ... (f (node-left v)) ...
;      ... (f (node-right v)) ...)]))

(define (contains-bt? bt n)
  (cond
    [(no-info? bt) #false]
    [else
     (or (equal? n (node-ssn bt))
         (contains-bt? (node-left bt) n) 
         (contains-bt? (node-right bt) n))]))
;=323================================================;
; Number BT -> [Maybe Symbol]
; produces name of some node in bt with ssn, n. if not found, #false.

(check-expect (search-bt NONE 10) #false)
(check-expect (search-bt n63 10) 'h)
(check-expect (search-bt n89 10) #false)

(define (search-bt bt n)
  (cond
    [(no-info? bt) #false]
    [else
     (cond
       [(= (node-ssn bt) n) (node-name bt)]
       [(contains-bt? (node-left bt) n) (search-bt (node-left  bt) n)]
       [else (search-bt (node-right bt) n)])]))
;=324================================================;
; BT -> [List-of Number]
; produces the sequence of ssn numbers in tree, bt,
; from left to right

;(check-expect (inorder NONE) '())
;(check-expect (inorder n89) (list 77 89 95 99))
(check-expect (inorder n1) (list 3 1 2))

(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else
     (append (inorder (node-left bt))
             (list (node-ssn bt))
             (inorder (node-right bt)))]))
;=325================================================;
; BST Number -> Symbol
; If the tree contains a node whose ssn field is n,
; produces the value of the name field in that node.
; Otherwise, produces NONE.

(check-expect (search-bst NONE 10) NONE)
(check-expect (search-bst n89 24) NONE)
(check-expect (search-bst n63 63) 'a)
(check-expect (search-bst n63 24) 'i)
(check-expect (search-bst n63 77) 'l)

(define (search-bst bst n)
  (cond
    [(no-info? bst) NONE]
    [else
     (cond [(= n (node-ssn bst)) (node-name bst)]
           [(< n (node-ssn bst)) (search-bst (node-left bst) n)]
           [else (search-bst (node-right bst) n)])]))
;=326===============================================;
; BST Number Symbol -> BST
; create bst like given bst, b, with added node with
; ssn, n, and name, s, at appropriate location.

(check-expect (create-bst NONE 0 'a) (make-node 0 'a NONE NONE))
(check-expect (inorder (create-bst n63 30 'b))
              (list 10 15 24 29 30 63 77 89 95 99))
(check-expect (inorder (create-bst n63 5 'b))
              (list 5 10 15 24 29 63 77 89 95 99))
(check-expect (inorder (create-bst n63 12 'b))
              (list 10 12 15 24 29 63 77 89 95 99))
(check-expect (inorder (create-bst n63 20 'b))
              (list 10 15 20 24 29 63 77 89 95 99))
(check-expect (inorder (create-bst n63 25 'b))
              (list 10 15 24 25 29 63 77 89 95 99))
(check-expect (inorder (create-bst n63 76 'b))
              (list 10 15 24 29 63 76 77 89 95 99))
(check-expect (inorder (create-bst n63 78 'b))
              (list 10 15 24 29 63 77 78 89 95 99))
(check-expect (inorder (create-bst n63 94 'b))
              (list 10 15 24 29 63 77 89 94 95 99))
(check-expect (inorder (create-bst n63 100 'b))
              (list 10 15 24 29 63 77 89 95 99 100))
(check-expect (inorder (create-bst n63 96 'b))
              (list 10 15 24 29 63 77 89 95 96 99))

(define (create-bst b n s)
  (cond
    [(no-info? b) (make-node n s NONE NONE) ]
    [else
     (local ((define ssn (node-ssn b))
             (define name (node-name b))
             (define left (node-left b))
             (define right (node-right b)))
     (if (< n ssn)
        (make-node ssn name (create-bst left n s) right)
        (make-node ssn name left (create-bst right n s))))]))
;=327===============================================;
; [List-of [List Number Symbol]] -> BST
; consumes list of numbers and names pair
; and produces a BST.

(check-expect (create-bst-from-list '()) NONE)
(check-expect (create-bst-from-list '((10 a)))
              (make-node 10 'a NONE NONE))
(check-expect (create-bst-from-list '((15 c) (5 b) (10 a)))
              (make-node 10 'a (make-node 5 'b NONE NONE) (make-node 15 'c NONE NONE)))
(check-expect(create-bst-from-list '((99 o) (77 l) (24 i)
                                     (10 h) (95 g) (15 d)
                                     (89 c) (29 b) (63 a))) n63)

;(define (create-bst-from-list l)
;  (cond
;    [(empty? l) NONE]
;    [else
;     (create-bst (create-bst-from-list (rest l))
;                 (first (first l))
;                 (second (first l)))]))

(define (create-bst-from-list l)   
  (foldr (λ (p bst) (create-bst bst (first p) (second p))) NONE l))
