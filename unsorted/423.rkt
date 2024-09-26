;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |423|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; String N -> [List-of String]
; produces a list of string chunks of size n

(check-expect (partition "" 3) '())
(check-expect (partition "ab" 3) '("ab"))
(check-expect (partition "abcdefg" 3)
              '("abc" "def" "g"))
(check-error (partition "ab" 0))

(define (partition s n)
  (local ((define length (string-length s)))
    (cond
      [(zero? n)
       (error "partition: n must greater than 0")]
      [(zero? length) '()]
      [else
       (cond
         [(< length n) (list s)]
         [else
          (cons (substring s 0 n)
                (partition (substring s n) n))])])))
