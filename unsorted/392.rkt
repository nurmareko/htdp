;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |392|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct branch [left right])
 
; A TOS is one of:
; – Symbol
; – (make-branch TOS TOS)
 
; A Direction is one of:
; – 'left
; – 'right
 
; A list of Directions is also called a path. 
;====================================================;
; TOS [List-of Direction] -> TOS
; pick an insntance of tos base on the given list of
; direction

(check-expect (tree-pick 'a '()) 'a)
(check-error (tree-pick 'a '(left)))
(check-expect (tree-pick (make-branch 'a 'b) '()) (make-branch 'a 'b))
(check-expect (tree-pick (make-branch 'a 'b) '(right)) 'b)
(check-expect (tree-pick (make-branch 'a (make-branch 'b 'c)) '(right left)) 'b)

(define (tree-pick tos ld)
  (cond
    [(empty? ld) tos]
    [(symbol? tos) (error "error")]
    [(branch? tos)
     (if (symbol=? 'left (first ld))
         (tree-pick (branch-left tos) (rest ld))
         (tree-pick (branch-right tos) (rest ld)))]))

;(define (tree-pick tos ld)
;  (cond
;    [(and (symbol? tos) (empty? ld)) tos]
;    [(and (symbol? tos) (cons? ld)) (error "error")]
;    [(and (branch? tos) (empty? ld)) tos]
;    [(and (branch? tos) (cons? ld))
;     (cond
;       [(symbol=? 'left (first ld))
;        (tree-pick (branch-left tos) (rest ld))]
;       [(symbol=? 'right (first ld))
;        (tree-pick (branch-right tos) (rest ld))])]))

;(define (tree-pick tos ld)
;  (cond
;    [(and (symbol? tos) (empty? ld))
;     ...]
;    [(and (symbol? tos) (cons? ld))
;     (... (first ld) ... (rest ld) ...)]
;    [(and (branch? tos) (empty? ld))
;     (... (branch-left tos) ... (branch-right tos) ...)]
;    [(and (branch? tos) (cons? ld))
;     (... (branch-left tos) ... (branch-right tos) ...
;      ... (first ld) ... (rest ld) ...)]))