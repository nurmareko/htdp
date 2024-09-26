;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |211|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "words.txt")

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary 
(define (in-dictionary los)
  (cond
    [(empty? los) los]
    [else (if (member? (first los) AS-LIST)
              (cons (first los)
                    (in-dictionary (rest los)))
              (in-dictionary (rest los)))]))

; tests
(check-expect (in-dictionary empty)
              empty)
(check-expect (in-dictionary (list "cat" "cta" "tca"
                                   "tac" "act" "atc"))
              (list "cat" "act"))