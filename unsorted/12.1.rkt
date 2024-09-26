;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12.1|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; On OS X: 
;(define LOCATION "words.txt")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
;(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

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
(check-expect (starts-with# "a" empty)
              0)
(check-expect (starts-with# "a" (list "be" "ce"))
              0)
(check-expect (starts-with# "a" (list "a" "be" "ce"))
              1)
(check-expect (starts-with# "a" (list "be" "ce" "aa" "aa"))
              2)
(check-expect (first-str "apple")
              "a")
(check-expect (first-str "balls")
              "b")
(check-expect (first-str "a")
              "a")