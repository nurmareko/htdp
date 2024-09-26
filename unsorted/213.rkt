;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |213|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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
; creates all rearrangements of the letters in w
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

; 1String List-of-words -> List-of-words
; list of words like its second argument, but with
; the first argument inserted at the beginning,
; between all letters, and at the end of all words of
; the given list.
(define (insert-everywhere/in-all-words let low)
  (cond
    [(empty? low) low]
    [else
     (append (all-position let (first low))
             (insert-everywhere/in-all-words let (rest low)))]))

; 1String Word -> List-of-words
; inserts a letter into a word
(define (all-position let w)
  (cond
    [(empty? w) (list (list let))]
    [else (cons (cons let w)
                (add-at-first (first w)
                              (all-position let (rest w))))]))

; 1String List-of-words -> List-of-words
; adds letter l at all the beginnings of words in the given w
(define (add-at-first l w)
  (cond
    [(empty? w) w]
    [else (cons (cons l (first w))
                (add-at-first l (rest w)))]))

; functional examples:
;(check-expect (arrangements empty-word)
;              (list empty))
;(check-expect (arrangements single-letter-word)
;              single-word-low)
;(check-expect (arrangements two-letter-word)
;              two-word-low)
;(check-expect (arrangements (list "e" "r"))
;              (list (list "e" "r")
;                    (list "r" "e")))
;(check-expect
; (insert-everywhere/in-all-words "x" empty-low)
; empty-low)
;(check-expect
; (insert-everywhere/in-all-words "x" empty-word-low)
; (list (list "x")))
;(check-expect
; (insert-everywhere/in-all-words "x" single-word-low)
; (list (list "x" "d")
;       (list "d" "x")))
;(check-expect
; (insert-everywhere/in-all-words "x" two-word-low)
; (list (list "x" "d" "e")
;       (list "d" "x" "e")
;       (list "d" "e" "x")
;       (list "x" "e" "d")
;       (list "e" "x" "d")
;       (list "e" "d" "x")))
;(check-expect
; (insert-everywhere/in-all-words "d" (list (list "e" "r")
;                                           (list "r" "e")))
; (list (list "d" "e" "r")
;       (list "e" "d" "r")
;       (list "e" "r" "d")
;       (list "d" "r" "e")
;       (list "r" "d" "e")
;       (list "r" "e" "d")))
;(check-expect (all-position "x" empty-word)
;              (list (list "x")))
;(check-expect (all-position "x" single-letter-word)
;              (list (list "x" "d")
;                    (list "d" "x")))
;(check-expect (all-position "x" two-letter-word)
;              (list (list "x" "d" "e")
;                    (list "d" "x" "e")
;                    (list "d" "e" "x")))
(check-expect (add-at-first "x" empty-low)
              empty-low)
(check-expect (add-at-first "x" empty-word-low)
              (list (list "x")))
(check-expect (add-at-first "x" single-word-low)
              (list (list "x" "d")))
(check-expect (add-at-first "x" two-word-low)
              (list (list "x" "d" "e")
                    (list "x" "e" "d")))