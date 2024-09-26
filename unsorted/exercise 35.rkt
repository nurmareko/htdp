;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 35|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Exercise 35. Design the function string-last, 
;which extracts the last character from a non-empty string.

;non-empty string is a String.
;first character is a 1String.

; consume a String and produce a String:
; String -> String 
; extract a-string substring and produce "a" 
; (define (f a-string) "a")

; given:
;	"world"
; expected:
;	"d"
; (define (f "world") "d")

; (define (string-last s)
;   (... s ...))

(define (string-last s)
  (string-ith s (- (string-length s)  1)))

(string-last "world")
