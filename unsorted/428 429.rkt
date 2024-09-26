;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |428 429|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon assume the numbers are all distinct
; use insert sort algorithm if alon length is less than THRESHOLD
; otherwise use quick sort algorithm

(check-expect (quick-sort < (list 11 8 14 7)) '(7 8 11 14))
(check-expect (quick-sort < (list 5 1 2 1)) '(1 1 2 5))

(define (quick-sort comp alon)
  (cond
    [(empty? alon) '()]
    [(= 1 (length alon)) alon]
    [else
     (local ((define pivot (first alon))
             (define rest-list (rest alon)))
       (append (quick-sort comp (filter (lambda (x) (comp x pivot)) rest-list))
               (list pivot)
               (quick-sort comp (filter (lambda (x) (not (comp x pivot))) rest-list))))]))

