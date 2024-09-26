;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 212-213) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; List-of-Words is one of:
; – empty
; – (cons Word List-of-Words)

; Word examples:
(define de
  (list "d" "e"))
(define ed
  (list "e" "d"))
(define bone
  (list "b" "o" "n" "e"))

; Word -> List-of-words
; creates all rearrangements of the letters in w
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

; 1String List-of-words -> List-of-words
; create a list of words like its second argument,
; but with the first argument inserted at the
; beginning, between all letters, and at the end of
; all words of the given list.
(define (insert-everywhere/in-all-words let li)
  (cond
    [(empty? (rest li)) ...]

; functional examples
(check-expect (arrangements empty)
              empty)
(check-expect (arrangements de)
              (list de ed))
(check-expect
 (insert-everywhere/in-all-words "a" (list empty))
 (list (list "a")))
(check-expect
 (insert-everywhere/in-all-words "d" (list (list "e")))
 (list (list "d" "e")
       (list "e" "d")))
(check-expect
 (insert-everywhere/in-all-words "c" (list (list "a" "t")))
 (list (list "c" "a" "t")
       (list "a" "c" "t")
       (list "a" "t" "c")))