;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |275 v4|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "words.txt")

; A Dictionary is a [List-of String].
 (define AS-LIST (read-lines LOCATION))

; A Letter is equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define-struct lc [letter count])
; Letter-Counts is (make-LC 1String Number)
; a piece of data that combines letters and counts.
(define BASE-LC (make-lc " " 0))
;====================================================;
; [List-of LetCounts] -> LetCounts
; produces the Letter-Count for the letter that is
; most frequently used as the first letter of the
; given Dictionary.

(check-expect (most-frequent AS-LIST)
              (make-lc "s" 22759))

(define (most-frequent dic)
  (local (; create list of LetCounts for every Letter in LETTERS
          (define listed-lc
            (local (; Letter Dictionary -> LetCounts
                    (define (create-lc 1-s)
                      (make-lc 1-s (count 1-s dic))))
              ; - IN -
              (map create-lc LETTERS))))
    ; - IN -
    (argmax lc-count listed-lc)))

; Letter Dictionary -> Number
; count for 1-s used as first letter in dic.
(define (count 1-s dic)
  (local (; String Number -> Number
          (define (start-with s n)
            (return string=? 1-s (substring s 0 1)
                    (add1 n) n)))
    ; - IN -
    (foldl start-with 0 dic)))

; [X X -> Boolean] X X Y Y -> Y
; return y1 for which f holds, else return y2.
(define (return f x1 x2 y1 y2)
  (if (f x1 x2) y1 y2))
;====================================================;
; Dictionary -> [List-of Dictionary]
; produces a list of Dictionarys, one per Letter.

(check-expect
 (words-by-first-letter (list "aa" "ab" "ba"))
 (list (list "aa" "ab") (list "ba")))

(define (words-by-first-letter dic)
  (local (; 1String -> [List-of String]
          (define (group 1-s)
            (local (; String -> Boolean
                    (define (start-with? s)
                      (equal? 1-s (substring s 0 1))))
              ; - IN -
              (filter start-with? dic))))
    ; - IN -
    (remove-all empty (map group LETTERS))))