;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |289|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; String [List-of String] -> Boolean
; is any of ln value equal to n?

(check-expect (find-name "doe" (list "john" "doe"))
              #true)
(check-expect (find-name "patrick" (list "john" "doe"))
              #false)

(define (find-name n ln)
  (ormap (lambda (x) (equal? x n)) ln))

; String [List-of String] -> Boolean
; is all item of ln start with 1String s?

(check-expect
 (all-start-with "p" (list "patrick" "paddy" "pamela"))
 #true)
(check-expect
 (all-start-with "p" (list "patrick" "lisa" "pamela"))
 #false)

(define (all-start-with s ln)
  (andmap (lambda (x)
            (equal? (substring x 0 1) s)) ln))

; Number [List-of String] -> Boolean
; is any string length in ln exceed n?

(check-expect (exceed? 5 (list "john" "james")) #false)
(check-expect (exceed? 4 (list "john" "james")) #true)

(define (exceed? n ln)
  (ormap (lambda (x) (> (string-length x) n)) ln))