;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |505|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N[>=1] -> Boolean
; is n a prime number?

(check-expect (is-prime? 2)  #true)
(check-expect (is-prime? 3)  #true)
(check-expect (is-prime? 97) #true)
(check-expect (is-prime? 1)  #false)
(check-expect (is-prime? 10) #false)
(check-expect (is-prime? 57) #false)

(define (is-prime? n0)
  (local (; N[>=1] N -> Boolean
          ; is n a prime number?
          ; accumulator a is n0 initial value
          (define (is-prime/a? n a)
            (cond
              [(= 1 n) #true]
              [else
               (if (zero? (remainder a n))
                   #false
                   (is-prime/a? (sub1 n) a))])))
    (if (= 1 n0)
        #false
        (is-prime/a? (sub1 n0) n0))))
