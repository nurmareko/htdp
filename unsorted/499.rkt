;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |499|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> Number
; compute the product of a list of numbers

(check-expect (product '()) 1)
(check-expect (product '(10 3)) 30)

(define (product alon)
  (cond
    [(empty? alon) 1]
    [else
     (* (first alon)
        (product (rest alon)))]))

;====================================================;

; [List-of Number] -> Number
; compute the product of a list of numbers

(check-expect (product.v2 '()) 1)
(check-expect (product.v2 '(10 3)) 30)

(define (product.v2 alon0)
  (local (; [List-of Number] Number -> Number
          ; compute the product of a list of numbers
          ; accumulator 'a' is the product of numbers
          ; that alon lacks from alon0 
          (define (product/a alon a)
            (cond
              [(empty? alon) a]
              [else
               (product/a (rest alon)
                          (* (first alon) a))])))
    (product/a alon0 1)))

; (product '(10 3))
; == (product/a '(10 33) ...)
; == (product/a '(3) ... 10 ...)
; == (product/a '() ... 3 ... 10 ...)
; accumulator 'a' is the product of numbers that alon lacks from alon0 

; The performance of product is O(n) where n is the length of the list.
; Does the accumulator version improve on this?

; No, the accumulator version performance also O(n).