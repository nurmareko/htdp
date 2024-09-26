;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |enumerate ISL for loops|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [List-of X] -> [List-of [List N X]]
; pairs each item in lx with its index

(check-expect (enumerate0 '()) '())
(check-expect
 (enumerate0 (list "g" "o" "o" "d"))
 (list '(1 "g") '(2 "o") '(3 "o") '(4 "d")))

(define (enumerate0 l)
  (local ((define (enumerate l n)
            (cond
              [(empty? l) l]
              [else
               (cons (list (add1 n) (first l))
                     (enumerate (rest l) (add1 n)))])))
    ; - IN -
    (enumerate l 0)))

; [List-of X] -> [List-of [List N X]]
; pairs each item in lx with its index 
 
(check-expect (enumerate1 '()) '())
(check-expect
 (enumerate1 (list "g" "o" "o" "d"))
 (list '(1 "g") '(2 "o") '(3 "o") '(4 "d")))
 
(define (enumerate1 lx)
  (for/list ([x lx] [ith (length lx)])
    (list (+ ith 1) x)))