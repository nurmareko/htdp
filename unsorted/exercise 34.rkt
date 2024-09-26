;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 34|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Exercise 34. Design the function string-first, which extracts 
;the first character from a non-empty string. Don’t worry about 
;empty strings. 

;non-empty string is a String.
;first character is a 1String at position 0.

; consume a String snd Produce a String:
; String -> String
; extract a-string substring and produce "a" 
; (define (f a-string) "a")

; given: 
;	"hello" for a-string
; expected:
;	"h"
; (define (f a-string) "a")

;(define (string-first s)
;  (... s ...))

(define (string-first s) 
	(string-ith s 0))

;(string-first "hello")







