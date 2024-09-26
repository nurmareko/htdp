;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 11-20|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;exercise 13
(define (string-first s)
  (string-ith s 0))

;exercise 14
(define (string-last s)
  (string-ith s (- (string-length s) 1)))

;exercise 18
(define (string-join s1 s2)
  (string-append s1 s2))

;exercise 19
(define (string-insert str i s)
  (string-append (substring str 0 i) s (substring str i)))

;exercise 20
(define (string-delete str i)
  (string-append (substring str 0 i) (substring str (+ i 1))))

(define ex "")