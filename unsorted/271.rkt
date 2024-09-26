;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |271|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; String [List-of String] -> Boolean
; determines whether any of the names on the latter
; are equal to or an extension of the former.

(check-expect (find-name "james" (list "john" "doe"))
              #false)
(check-expect (find-name "doe" (list "john" "doe"))
              #true)

(define (find-name s l)
  (local (; String -> Boolean
          (define (found? n)
            (string=? n s)))
    ; - IN -
    (ormap found? l)))
;====================================================;
; [List-of String] -> Boolean
; checks all names on a list of names that start with
; the letter "a".

(check-expect (all-start-with-a? (list "amir" "khan"))
              #false)
(check-expect (all-start-with-a? (list "amir" "ama"))
              #true)

(define (all-start-with-a? l)
  (local (; String -> Boolean
          (define (start-with-a? s)
            (string=? (substring s 0 1) "a")))
    ; - IN -
    (andmap start-with-a? l)))