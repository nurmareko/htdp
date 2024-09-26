;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 196-generalize) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Los (NE-list-of-String) is
; - (list String)
; - (list String NELos)
; ex:
(define ass
  (list "ass"))
(define balls-ass
  (cons "balls" ass))
(define 3balls
  (list "balls" "balls" "balls" ))

; Lo1s (NE-list-of-1String) is
; - empty
; - (list 1String NELo1s)
; ex:
(define b
  (list "b"))
(define ab
  (list "a" "b"))

(define-struct LC [letter count])
; LC (Letter-Counts) is (make-LC Letter Number)
; a piece of data that combines letters and counts.

; LLC (List-of-Letter-Counts) is:
; - empty
; - (list LC LLC)
; ex:
(define ab-on-3balls
  (list (make-LC "a" 0) (make-LC "b" 3)))

; Dictionary Letter -> LLC
; counts how often each Letter is used as the first
; one of a word in the given dictionary.
(define (count-by-letter dict letter)
  (cond
    [(empty? letter) letter]
    [else (cons (make-LC (first letter) (starts-with# (first letter) dict))
                (count-by-letter dict (rest letter)))]))

; Letter Dictionary -> Number
; counts how many words in the given Dictionary li
; start with the given Letter s.
(define (starts-with# s li)
  (cond
    [(empty? li) 0]
    [else (if (string=? s (first-str (first li)))
              (+ 1 (starts-with# s (rest li)))
              (starts-with# s (rest li)))]))           

; String -> 1String
; extract the first 1String from str
(define (first-str str)
  (substring str 0 1))

; tests
(check-expect (count-by-letter 3balls ab)
              ab-on-3balls)