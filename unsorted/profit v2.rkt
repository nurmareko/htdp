;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |profit v2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;constants
(define sample-price 5.0)
(define average-people-per-sample-price 120)
(define change-in-ticket-price 0.10)
(define average-attendace-by-change-in-ticket-price 15)
(define attendance-cost 1.50)
(define PRICE-SENSITIVITY-OF-ATTENDANCE
  (/ average-attendace-by-change-in-ticket-price change-in-ticket-price))

  
;functions   $2.90 is the most profitable
(define (attendees ticket-price)
  (- average-people-per-sample-price
     (* (- ticket-price sample-price)
        PRICE-SENSITIVITY-OF-ATTENDANCE)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* attendance-cost (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(define p1 1)
(define p2 2)
(define p3 3)
(define p4 4)
(define p5 5)

(define (best-ticket-price price)
  (string-append "price:$" (number->string price) " profit:$" (number->string (ceiling (profit price)))))

(string-append (best-ticket-price p1) " "
               (best-ticket-price p2) " "
               (best-ticket-price p3) " "
               (best-ticket-price p4) " "
               (best-ticket-price p5))



  