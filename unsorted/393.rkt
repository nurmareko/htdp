;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |393|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Son is one of: 
; – empty 
; – (cons Number Son)
; 
; Constraint If s is a Son, 
; no number occurs twice in s
;====================================================;
; Son Son -> Son
; produces sets of number that contains the elements
; of both sa and sb

(check-expect (union '() '(3 4)) '(3 4))
(check-expect (union '() '()) '())
(check-expect (union '(1 2) '(3 4)) '(1 2 3 4))
(check-expect (union '(1 2) '()) '(1 2))
(check-expect (union '(1 2) '(2 3)) '(1 2 3))

;(define (union sa sb)
;  (cond
;    [(empty? sa) sb]
;    [else
;     (if (member? (first sa) sb)
;         (union (rest sa) sb)
;         (cons (first sa) (union (rest sa) sb)))]))

(define (union sa sb)
  (foldr (lambda (a b) (if (member? a b) b (cons a b))) sb sa))

;(define (union sa sb)
;  (cond
;    [(and (empty? sa) (empty? sb)) '()]
;    [(and (empty? sa) (cons? sb)) sb]
;    [(and (cons? sa) (empty? sb)) sa]
;    [(and (cons? sa) (cons? sb))
;     (... (first sa) ... (rest sa) ...
;      ... (first sb) ... (rest sb) ...)]))

;(define (union sa sb)
;  (cond
;    [(and (empty? sa) (empty? sb)) '()]
;    [(and (empty? sa) (cons? sb)) sb]
;    [(and (cons? sa) (empty? sb)) sa]
;    [(and (cons? sa) (cons? sb))
;     (if (member? (first sa) sb)
;         (union (rest sa) sb)
;         (cons (first sa) (union (rest sa) sb)))]))
;====================================================;
; Son son -> son
; produces the set of exactly those elements that
; occur in both.

(check-expect (intersect '() '(3 4)) '())
(check-expect (intersect '() '()) '())
(check-expect (intersect '(1 2) '(3 4)) '())
(check-expect (intersect '(1 2) '()) '())
(check-expect (intersect '(1 2) '(2 3)) '(2))

;(define (intersect a b)
;  (cond
;    [(empty? a) '()]
;    [else
;     (if (member? (first a) b)
;         (cons (first a) (intersect (rest a) b))
;         (intersect (rest a) b))]))

(define (intersect la lb)
  (foldr (lambda (a b) (if (member? a lb) (cons a b) b)) '() la))

;(define (intersect a b)
;  (cond
;    [(empty? a) ...]
;    [else
;     (... (first a) b ...
;      ... (intersect (rest a) b) ...))]))
