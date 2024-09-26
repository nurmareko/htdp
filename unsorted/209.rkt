;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |209|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of
; 1Strings (letters)

; A List-of-words is ...

; Word -> List-of-words
; finds all rearrangements of word.
(define (arrangements word)
  (list word))

; String -> Word
; converts s to the chosen word representation.
(define (string->word s)
  (explode s))
 
; Word -> String
; converts w to a string.
(define (word->string w)
  (implode w))

; tests
(check-expect (string->word "") empty)
(check-expect (string->word "A") (list "A"))
(check-expect (string->word "dog") (list "d" "o" "g"))
(check-expect (word->string empty) "")
(check-expect (word->string (list "A")) "A")
(check-expect (word->string (list "d" "o" "g")) "dog")