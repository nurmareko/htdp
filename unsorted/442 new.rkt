;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |442 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> [List-of Number]
; produces a sorted variant of alon
; assume the numbers are all distinct

;(check-expect (quick-sort< '(11 11 9 2 18 12 14 4 1))
;              '(1 2 4 9 11 11 12 14 18))

(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers (rest alon) pivot))
                    (list pivot)
                    (quick-sort< (largers (rest alon) pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))
 
; [List-of Number] Number -> [List-of Number]
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (<= (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))
;====================================================;
; List-of-numbers -> List-of-numbers
; produces a sorted variant of l

;(check-expect (sort< '(11 11 9 2 18 12 14 4 1))
;              '(1 2 4 9 11 11 12 14 18))

(define (sort< l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort< (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (<= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

;====================================================;
; N -> [list- of N]
; create a list of length n with random number between
; 0 and n as its items.

;(check-expect (length (create-tests 10)) 10)
;(check-random (create-tests 3)
;              (list (random 3) (random 3) (random 3)))

;(define (create-tests n)
;  (local ((define N n))
;    (build-list n (lambda (x) (random N)))))
;====================================================;
;(define for-test (create-tests 150))
;(time (sort< for-test))
; cpu time: 15 real time: 5 gc time: 0
;(time (quick-sort< for-test))
; cpu time: 0 real time: 1 gc time: 0

; around list of length 150, quick-sort< shows that it
; is faster than sort< when processing larger list.
;====================================================;
(define CROSS-OVER 5) ; 5 is example value, 150 is
                      ; the effective value.

; [List-of N] -> [List-of N]
; produces a sorted variant of l

(check-expect (clever-sort '(11 11 9 2 18 12 14 4 1))
              '(1 2 4 9 11 11 12 14 18))

(define (clever-sort ln)
  (cond
    [(or (empty? ln) (empty? (rest ln))) ln]
    [(< (length ln) CROSS-OVER)
     (insert (first ln) (clever-sort (rest ln)))]
    [else
     (local ((define pivot (first ln)))
       (append (clever-sort (smallers (rest ln) pivot))
               (list pivot)
               (clever-sort (largers (rest ln) pivot))))]))
