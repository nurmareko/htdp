;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |442|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define CROSS-OVER 400) ; the cross over point for clever-sort
(define MAX 1000) ; the maximum number interval for create-tests

; Insert Sort =======================================;
; [List-of Number] -> [List-of Number]
; produces a sorted version of l

(check-expect (sort< '()) '())
(check-expect (sort< '(1)) '(1))
(check-expect (sort< '(1 2 1 1 5 4 3)) '(1 1 1 2 3 4 5))
(check-expect (sort< '(1 2 3 4 5)) '(1 2 3 4 5))

(define (sort< l)
  (local (; Number List-of-numbers -> List-of-numbers
          ; inserts n into the sorted list of numbers l 
          (define (insert n l)
            (cond
              [(empty? l) (cons n '())]
              [else (if (<= n (first l))
                        (cons n l)
                        (cons (first l) (insert n (rest l))))])))
    (cond
      [(empty? l) '()]
      [(cons? l) (insert (first l) (sort< (rest l)))])))

; Quick Sort ========================================;
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon

(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1)) '(1))
(check-expect (quick-sort< '(1 2 1 1 5 4 3)) '(1 1 1 2 3 4 5))
(check-expect (quick-sort< '(1 2 3 4 5)) '(1 2 3 4 5))

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
    [else (if (not (< (first alon) n))
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))
; [List-of Number] Number -> [List-of Number]
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))
;====================================================;
; Number -> [List-of Number]
; create list of number of length n with random
; chosen number between 0 and MAX
; as it component

(check-expect (length (create-tests 10)) 10)

(define (create-tests n)
  (build-list n (lambda (x) (random MAX))))
;====================================================;
;(define test0 (create-tests 400))
;(time (sort< test0))
;(time (quick-sort< test0))
;====================================================;
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon

(check-expect (clever-sort '()) '())
(check-expect (clever-sort '(1)) '(1))
(check-expect (clever-sort '(1 2 1 1 5 4 3)) '(1 1 1 2 3 4 5))
(check-expect (clever-sort '(1 2 3 4 5)) '(1 2 3 4 5))
(check-expect (length (clever-sort (create-tests 500))) 500)

(define (clever-sort alon)
  (cond
    [(< (length alon) CROSS-OVER) (sort< alon)]
    [else
     (local ((define pivot (first alon)))
       (append (quick-sort< (smallers (rest alon) pivot))
               (list pivot)
               (quick-sort< (largers (rest alon) pivot))))]))