;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |270|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> [List-of Number]
; creates the list (list 0 ... (- n 1)) for any
; natural number n

(check-expect (f-1 0) '())
(check-expect (f-1 3) (list 0 1 2))

(define (f-1 n) (build-list n +))

; Number -> [List-of Number]
; creates the list (list 1 ... n) for any natural
; number n

(check-expect (f-2 0) '())
(check-expect (f-2 3) (list 1 2 3))

(define (f-2 n) (build-list n add1))

; Number -> [List-of Number]
; creates the list (list 1 1/2 ... 1/n) for any
; natural number n

(check-expect (f-3 0) '())
(check-expect (f-3 3) (list 1 1/2 1/3))

(define (f-3 n)
  (local (; Number -> Number
          (define (f x) (/ 1 (add1 x))))
    ; - IN -
    (build-list n f)))

; Number -> [List-of Number]
; creates the list of the first n even numbers

(check-expect (f-4 0) '())
(check-expect (f-4 3) (list 0 2 4))

(define (f-4 n)
  (local (; Number -> Number
          (define (f x) (* x 2)))
    ; - IN -
    (build-list n f)))