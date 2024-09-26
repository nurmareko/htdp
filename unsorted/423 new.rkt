;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |423 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; String N -> [List-of String]
; bundle subtrings of s into strings of length n

(check-expect (partition "" 2) '())
(check-expect (partition "abc" 1) '("a" "b" "c"))
(check-expect (partition "abc" 2) '("ab" "c"))
(check-expect (partition "abc" 3) '("abc"))
(check-expect (partition "abc" 4) '("abc"))
(check-error (partition "abc" 0))

(define (partition s n)
  (local ((define length (string-length s)))
    (cond
      [(zero? n)
       (error "partition: n must greater than 0")]
      [(zero? length) '()]
      [else
       (if (< length n)
           (list s)
           (cons (substring s 0 n)
                 (partition (substring s n) n)))])))