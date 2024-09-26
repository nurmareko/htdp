;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |prime number function|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> Boolean
; is x a prime number?

(check-expect (prime? 0) #false)
(check-expect (prime? 1) #false)
(check-expect (prime? 2) #true)
(check-expect (prime? 3) #true)
(check-expect (prime? 4) #false)
(check-expect (prime? 11) #true)
(check-expect (prime? 25) #false)

(define (prime? x)
  (local (; N -> Boolean
          (define (prime? n)
            (cond
              [(= n 1) #true]
              [else
               (if (zero? (modulo x n))
                   #false
                   (prime? (sub1 n)))])))
    (if (<= x 1) #false (prime? (sub1 x)))))