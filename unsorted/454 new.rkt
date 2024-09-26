;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |454 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; N [List-of N] -> [List-of [List-of N]]
; produces an (* n n) image matrix,
; by composing list of number of length n from number
; in ln.

(check-expect (create-matrix 0 '()) '())
(check-expect (create-matrix 1 (list 1))
              (list (list 1)))
(check-expect (create-matrix 2 (list 1 2 3 4))
              (list (list 1 2)
                    (list 3 4)))
(check-expect (create-matrix 3 (list 1 2 3 4 5 6 7 8 9))
              (list (list 1 2 3)
                    (list 4 5 6)
                    (list 7 8 9)))

(define (create-matrix n ln)
  (cond
    [(empty? ln) '()]
    [else
     (cons (initial n ln)
           (create-matrix n (drop n ln)))]))

; [X] N [List-of X] -> [List-of X]
; take the first n item from a list.
(define (initial n alist)
  (cond
    [(or (empty? alist) (zero? n)) '()]
    [else
     (cons (first alist)
           (initial (sub1 n) (rest alist)))]))

; N [X] [List-of X] -> [List-of X]
; drop the first n item from alist.
(define (drop n alist)
  (cond
    [(or (zero? n) (empty? alist)) alist]
    [else
     (drop (sub1 n) (rest alist))]))