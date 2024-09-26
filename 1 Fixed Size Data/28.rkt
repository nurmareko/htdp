;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |28|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define BASE-ATTENDANCE 120)
(define BASE-PRICE 5.0)
(define CHANGE-ATTENDANCE 15)
(define CHANGE-PRICE 0.1)
(define COST-FIXED 180)
(define COST-VARIABLE 0.04)

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-PRICE) (/ CHANGE-ATTENDANCE CHANGE-PRICE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ COST-FIXED (* COST-VARIABLE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

; tickect price  profit
; $1.00          $ 511.20
; $2.00          $ 937.20
; $3.00          $1063.20
; $4.00          $ 889.20
; $5.00          $ 415.20
; $2.90          $1064.10

; the best ticket price to a dime is $2.90 