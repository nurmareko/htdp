;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |210|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; List-of-words -> List-of-strings
; turns all Words in low into Strings 
(define (words->strings low)
  (cond
    [(empty? low) low]
    [else (cons (word->string (first low))
                (words->strings (rest low)))]))

; Word -> String
; converts w to a string.
(define (word->string w)
  (implode w))

; tests
(check-expect (words->strings empty)
              empty)
(check-expect (words->strings (list (list "d" "o" "g")
                                    (list "a" "t")))
              (list "dog" "at"))