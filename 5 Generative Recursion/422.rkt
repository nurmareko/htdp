;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |422 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n idea
; take n items and drop n at a time

(check-expect (bundle '() 1) '())
(check-expect (bundle (explode "hello world") 4)
              '("hell" "o wo" "rld"))

(define (bundle s n)
  (map implode (list->chunks s n)))
;====================================================;
; [X Y] [list-of X] N -> [List-of [List-of Y]]
; produce a list of list chunks of size n

(check-expect (list->chunks '() 2) '())
(check-expect (list->chunks '("a" "b" "c") 1)
              '(("a") ("b") ("c")))
(check-expect (list->chunks '("a" "b" "c") 2)
              '(("a" "b") ("c")))
(check-expect (list->chunks '("a" "b" "c") 3)
              '(("a" "b" "c")))
(check-expect (list->chunks '("a" "b" "c") 4)
              '(("a" "b" "c")))
(check-error (list->chunks '("a" "b" "c") 0))

(define (list->chunks l n)
  (cond
    [(zero? n)
     (error "list->chunks: n must larger than 0")]
    [(empty? l) '()]
    [(< (length l) n) (list l)]
    [else
     (cons (take l n)
           (list->chunks (drop l n) n ))]))

; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or
; everything

(define (take l n)
  (cond
    [(or (zero? n) (empty? l)) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
 
; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or
; everything

(define (drop l n)
  (cond
    [(or (zero? n) (empty? l)) l]
    [else (drop (rest l) (sub1 n))]))