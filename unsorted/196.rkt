;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |196|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; On OS X: 
(define LOCATION "words.txt")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define-struct LC [letter count])
; Letter-Counts is (make-LC Letter Number)
; a piece of data that combines letters and counts.

; LoLC (List-of-Letter-Counts) is:
; - empty
; - (list Letter-Counts LoLC)

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

; Dictionary -> LoLC
; counts how often each Letter is used as the first
; one of a word in the given dictionary.
(define (count-by-letter dict)
  (line-by-lo1s dict LETTERS))

; Los Lo1s -> LoLC
; counts how often each 1string in Lo1c is use as the
; start of line in Los
(define (line-by-lo1s los lo1s)
  (cond
    [(empty? lo1s) lo1s]
    [else (cons (make-LC (first lo1s)
                         (starts-with# (first lo1s) los))
                (line-by-lo1s los (rest lo1s)))]))

; tests
(check-expect
 (count-by-letter (list "a" "aAd" "b" "ab" "c"))
 (list (make-LC "a" 3) (make-LC "b" 1) (make-LC "c" 1)
       (make-LC "d" 0) (make-LC "e" 0) (make-LC "f" 0)
       (make-LC "g" 0) (make-LC "h" 0) (make-LC "i" 0)
       (make-LC "j" 0) (make-LC "k" 0) (make-LC "l" 0)
       (make-LC "m" 0) (make-LC "n" 0) (make-LC "o" 0)
       (make-LC "p" 0) (make-LC "q" 0) (make-LC "r" 0)
       (make-LC "s" 0) (make-LC "t" 0) (make-LC "u" 0)
       (make-LC "v" 0) (make-LC "w" 0) (make-LC "x" 0)
       (make-LC "y" 0) (make-LC "z" 0)))