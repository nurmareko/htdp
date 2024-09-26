;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |236|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(check-expect (add1* (list 1 2 3))
              (list 2 3 4))
(check-expect (plus5 (list 1 2 3))
              (list 6 7 8))

; [List-of N] -> [List-of N]
; add n to each item on l
(define (forge n l)
  (cond
    [(empty? l) '()]
    [else (cons (+ (first l) n)
                (forge n (rest l)))]))

; [List-of N] -> [List-of N]
; adds 1 to each item on l
(define (add1* l)
  (forge 1 l))

; [List-of N] -> [List-of N]
; adds 5 to each item on l
(define (plus5 l)
  (forge 5 l))
  