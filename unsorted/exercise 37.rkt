;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 37|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Exercise 37. Design the function string-rest, which
;produces a string like the given one with the first
;character removed.

; use String to producea string with the first
; character removed.

; consume a String and produce a String:
; String -> String
; calculate s String and remove sub-string at positon 0 to produce "x”.
; (define (f s) "x")

; given:
;     "good night"
; expected:
;     "ood night"
; given:
;     " james"
; expected:
;     "james"

(define (string-rest s)
 	(substring s 1))

(string-rest " james")
