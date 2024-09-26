;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |213 aux|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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

; 1String Word -> List-of-words
; create a list of word of let inserted at all
; possible position within wor.
(define (all-position let w)
  (cond
    [(empty? w) w]
    [else (function-x let (first w)
                      (all-position (rest w)))]))

; 1String Word -> Word
; insert let at the start of w.
(define (at-start let w)
  (list* let w))

; 1String Word -> Word
; insert let at the end of w.
(define (at-end let w)
  (reverse (list* let (reverse w))))

; 1String Word -> Word
; insert let at the start of w.
(define (between let w)
  (list (first w) let (second w)))

; tests
;(check-expect (all-position "x" empty-word)
;              empty)
;(check-expect (all-position "x" single-letter-word)
;              (list (list "x" "d")
;                    (list "d" "x")))
;(check-expect (all-position "x" two-letter-word)
;              (list (list "x" "d" "e")
;                    (list "d" "x" "e")
;                    (list "d" "e" "x")))
(check-expect (at-start "x" empty-word)
              (list "x"))
(check-expect (at-start "x" single-letter-word)
              (list "x" "d"))
(check-expect (at-start "x" two-letter-word)
              (list "x" "d" "e"))
(check-expect (at-end "x" empty-word)
              (list "x"))
(check-expect (at-end "x" single-letter-word)
              (list "d" "x"))
(check-expect (at-end "x" two-letter-word)
              (list "d" "e" "x"))
(check-expect (between "x" two-letter-word)
              (list "d" "x" "e"))