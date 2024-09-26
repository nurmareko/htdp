;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |425 426 |) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct

(check-expect (quick-sort< (list 11 8 14 7))
              '(7 8 11 14))

(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(= 1 (length alon)) alon]
    [else
     (local ((define pivot (first alon)))
       (append (quick-sort< (filter (lambda (x) (< x pivot)) alon))
               (list pivot)
               (quick-sort< (filter (lambda (x) (> x pivot)) alon))))]))

;====================================================;
; original steps are 249, revised steps are 83,
; its save a whopping 166 steps