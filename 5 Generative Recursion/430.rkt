;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |430 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [X X -> Boolean] -> [List-of Number]
; produces a sorted version of alon base on sign

(check-expect (quick-sort < '(11 11 9 2 18 12 14 4 1))
              '(1 2 4 9 11 11 12 14 18))
(check-expect (quick-sort > '(11 11 9 2 18 12 14 4 1))
              '(18 14 12 11 11 9 4 2 1))

(define (quick-sort sign alon)
  (cond
    [(or (empty? alon) (= (length alon) 1)) alon]
    [else
     (local ((define pivot (first alon))
             ; [List-of Number] -> [List-of Number]
             ; keep some element of alon that is smaller or equal to n
             (define (smallers alon)
               (filter (lambda (x) (not (sign pivot x))) alon))
             ; [List-of Number] -> [List-of Number]
             ; keep some element of alon that is larger than n
             (define (largers alon)
               (filter (lambda (x) (sign pivot x)) alon)))
       (append (quick-sort sign (smallers (rest alon)))
               (list pivot)
               (quick-sort sign (largers (rest alon)))))]))
