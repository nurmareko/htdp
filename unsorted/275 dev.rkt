;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |275 dev|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "words.txt")

; A Dictionary is a [List-of String].
 (define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))
(define PS-LETS (list "a" "b"))

(define-struct LC [letter count])
; Letter-Counts is (make-LC 1String Number)
; a piece of data that combines letters and counts.

; Dictionary -> Letter-Counts
; produces the Letter-Count for the letter that is
; most frequently used as the first one in the words
; of the given Dictionary.

;(check-expect (most-frequent (list "aa" "ab" "ba"))
;              (make-LC "a" 2))

(define (most-frequent dic)
  (local (; make list of Letter Counts
          (define listed-LC
            (local (; 1String -> Letter-Counts
                    (define (create-LC s)
                      (make-LC s (count s AS-LIST))))
              ; - IN -
              (map create-LC LETTERS)))
          ; sorted list of Letter Counts in ascending order.
          (define sorted-max
            (local (; Letter-Counts Letter-Counts -> Boolean
                    (define (max a b)
                      (> (LC-count a) (LC-count b))))
              ; - IN -
              (sort listed-LC max))))
    ; - IN -
    (first sorted-max)))

; 1String [List-of String] -> Number
; count how many times 1-s is use as the first letter inside ls.
(define (count 1-s ls)
  (local (; String -> Boolean
          (define (start-w? s)
            (string=? (substring s 0 1) 1-s)))
    ; - IN =
    (length (filter start-w? ls))))
