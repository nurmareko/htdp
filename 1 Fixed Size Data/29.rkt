;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |29|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define BASE-ATTENDANCE 120)
(define BASE-PRICE 5.0)
(define CHANGE-ATTENDANCE 15)
(define CHANGE-PRICE 0.1)
(define COST-VARIABLE 1.50)

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-PRICE) (/ CHANGE-ATTENDANCE CHANGE-PRICE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* COST-VARIABLE (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
;====================================================;
(define (profit* price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (* 1.50
        (+ 120
           (* (/ 15 0.1)
              (- 5.0 price))))))
;====================================================;
(profit 1)
(profit 2)
(profit 3)
(profit 4)
(profit 5)

(profit* 1)
(profit* 2)
(profit* 3)
(profit* 4)
(profit* 5)