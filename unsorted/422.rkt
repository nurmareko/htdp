;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |422|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
; idea take n items and drop n at a time

(check-expect (bundle '() 3) '())
(check-expect (bundle '("a" "b") 3) (list "ab"))
(check-expect (bundle (explode "abcdefg") 3)
              (list "abc" "def" "g"))

(define (bundle s n)
  (map implode (list->chunks s n)))
;====================================================;
; [X Y] [List-of X] N -> [List-of [List-of Y]]
; produce a list of list chunks of size n
(check-expect (list->chunks '() 3) '())
(check-expect (list->chunks '("a" "b") 3)`(("a" "b")))
(check-expect (list->chunks (explode "abcdefg") 3)
              `(("a" "b" "c") ("d" "e" "f") ("g")))

(define (list->chunks l n)
  (cond
    [(empty? l) '()]
    [(< (length l) n) (list l)]
    [else
     (cons (take l n) (list->chunks (drop l n) n))]))
;====================================================;
; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or
; everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
;====================================================;
; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or
; everything
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))