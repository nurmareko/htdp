;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |395|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [X Y] [List-of X] N -> [List-of Y]
; produces the first n items from l or all of l if
; it is too short.

(check-expect (take '() 0) '())
(check-expect (take '() 1) '())
(check-expect (take '(a) 0) '())
(check-expect (take '(a) 1) '(a))
(check-expect (take '(a b c) 2) '(a b))
(check-expect (take '(a b c) 5) '(a b c))

;(define (take l n)
;  (map (lambda
;           (a b) ...)
;       l
;       n)))

(define (take l n)
  (cond
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))

;(define (take l n)
;  (cond
;    [(and (empty? l) (= n 0))
;     '()]
;    [(and (empty? l) (> n 0))
;     l]
;    [(and (cons? l) (= n 0))
;     '()]
;    [(and (cons? l) (> n 0))
;     (cons (first l) (take (rest l) (sub1 n)))]))

;(define (take l n)
;  (cond
;    [(and (empty? l) (= n 0))
;     '()]
;    [(and (empty? l) (> n 0))
;     l]
;    [(and (cons? l) (= n 0))
;     '()]
;    [(and (cons? l) (> n 0))
;     (... (first l) ... (rest l) ... (sub1 n) ...)]))

;(define (take l n)
;  (cond
;    [(and (empty? l) (= 0 n))
;     ...]
;    [(and (empty? l) (> 0 n))
;     ...]
;    [(and (cons? l) (= 0 n))
;     ...]
;    [(and (cons? l) (> 0 n))
;     (... (first l) ... (rest l) ... (sub1 n) ...)]))
;====================================================;
; [X Y] [List-of X] N -> [List-of Y]
; produce list like l with the first n items removed
; or just ’() if l is too short.

(check-expect (drop '() 0) '())
(check-expect (drop '() 1) '())
(check-expect (drop '(a) 0) '(a))
(check-expect (drop '(a) 1) '())
(check-expect (drop '(a b c) 2) '(c))
(check-expect (drop '(a b c) 5) '())

(define (drop l n)
  (cond
    [(or (empty? l) (= n 0)) l]
    [else (drop (rest l) (sub1 n))]))

;(define (drop l n)
;  (cond
;    [(and (empty? l) (= n 0))
;     '()]
;    [(and (empty? l) (> n 0))
;     '()]
;    [(and (cons? l) (= n 0))
;     l]
;    [(and (cons? l) (> n 0))
;     (drop (rest l) (sub1 n))]))

;(define (drop l n)
;  (cond
;    [(and (empty? l) (= n 0))
;     '()]
;    [(and (empty? l) (> n 0))
;     '()]
;    [(and (cons? l) (= n 0))
;     l]
;    [(and (cons? l) (> n 0))
;     (... (first l) ... (rest l) ... (sub1 n) ...)]))

;(define (drop l n)
;  (cond
;    [(and (empty? l) (= 0 n))
;     ...]
;    [(and (empty? l) (> 0 n))
;     ...]
;    [(and (cons? l) (= 0 n))
;     ...]
;    [(and (cons? l) (> 0 n))
;     ...]))

