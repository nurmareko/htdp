;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |212|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; Word is one of:
; – empty
; – (cons 1String Word)

; Lists-of-Words is one of:
; - empty
; - (cons Word Lists-of-Words)

; Word examples:
(define empty-word
  empty)
(define single-letter-word
  (list "d"))
(define two-letter-word
  (list "d" "e"))

; Lists-of-Words examples:
(define empty-low
  empty)
(define empty-word-low
  (list empty))
(define single-word-low
  (list (list "d")))
(define two-word-low
  (list (list "d" "e")
        (list "e" "d")))

; Word -> List-of-words
; finds all rearrangements of word.
(define (arrangements word)
  (list word))

; functional examples:
(check-expect (arrangements empty-word)
              (list empty))
(check-expect (arrangements single-letter-word)
              single-word-low)
(check-expect (arrangements two-letter-word)
              two-word-low)
(check-expect (arrangements (list "e" "r"))
              (list (list "e" "r")
                    (list "r" "e")))