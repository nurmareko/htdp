;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |507|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X Y] [X Y -> Y] Y [List-of X] -> Y
; version 4
(define (f*ldl f e l0)
  (local (; Y [List-of X] -> Y
          ; ...
          ; accumulator 'a' is the result of the combined
          ; item from 'l0' that is missing in 'l' using 'f'
          (define (fold/a a l)
            (cond
              [(empty? l) a]
              [else
               (fold/a (f (first l) a) (rest l))])))
    (fold/a e l0)))
;====================================================;
; N -> [List-of X]
; Constructs a list by applying f to the numbers
; between 0 and (- n 1)

(check-expect (build-l*st 3 add1) (build-list 3 add1))

(define (build-l*st n0 f)
  (local (; N [List-of X] -> [List-of X]
          ; accumulator 'a' is the result list by
          ; applying f to some number from 0 to n,
          (define (build-list/a n a)
            (cond
              [(zero? n) a]
              [else
               (build-list/a (sub1 n)
                             (cons (f (sub1 n)) a))])))
    (build-list/a n0 '())))
