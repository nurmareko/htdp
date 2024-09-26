;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |444|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; N[>= 1] N[>= 1] -> N
; finds the greatest common divisor of n and m

(check-expect (gcd-structural 6 25) 1)
(check-expect (gcd-structural 18 24) 6)

(define (gcd-structural S L)
  (largest-common (divisors S S) (divisors S L)))
 
; N[>= 1] N[>= 1] -> [List-of N]
; computes the divisors of l smaller or equal to k

(check-expect (divisors 18 18) '(1 2 3 6 9 18))
(check-expect (divisors 18 24) '(1 2 3 4 6 8 12))

(define (divisors k l)
  (local (; N N -> [List-of N]
          (define (find-divisors n i)
            (cond
              [(< k i) '()]
              [else
               (if (= (remainder n i) 0)
                   (cons i (find-divisors n (add1 i)))
                   (find-divisors n (add1 i)))])))
    (find-divisors l 1)))

; [List-of N] [List-of N] -> N
; finds the largest number common to both k and l

(check-expect (largest-common '(1 2 3 6 9 18) '(1 2 3 4 6 8 12))
              6)

(define (largest-common k l)
  (local (; [List-of N] [List-of N] -> [List-of N]
          ; create a list with item that both appear in a and b
          (define (combine a b)
            (cond
              [(empty? a) '()]
              [else
               (if (member (first a) b)
                   (cons (first a) (combine (rest a) b))
                   (combine (rest a) b))])))
    (first (reverse (combine k l)))))