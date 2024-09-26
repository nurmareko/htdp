;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 38|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Exercise 38. Design the function string-remove-last, which
; produces a string like the given one with the last character
; removed. 

; string is a String.
; string like the given one with the last character removed is
; a String.

; consume a String and produce a String:
; String -> String
; remove sub-string at last position from a String
; (define (string-remove-last s) ... s ...)

(check-expect (string-remove-last "good night") "good nigh")
(check-expect (string-remove-last " james") " jame")

(define (string-remove-last s)
	(substring s 0 (- (string-length s) 1)))

