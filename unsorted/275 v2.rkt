;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |275 v2|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
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

(check-expect (most-frequent AS-LIST)
              (make-lc "s" 22759))

(define (most-frequent dic)
  (local (; create list of LetCounts for every Letter
          ; in LETTERS
          (define listed-lc (map create-lc LETTERS))
          ; LetCounts LetCounts -> LetCounts
          (define (max-count a b)
            (if (> (lc-count a) (lc-count b))
                a b)))
    ; - IN -
    (foldl max-count BASE-LC listed-lc)))

; Letter -> LetCounts
; create LetCount from 1-s.
(define (create-lc 1-s)
  (make-lc 1-s (count 1-s AS-LIST)))

; Letter Dictionary -> Number
; count for 1-s used as first letter in dic.
(define (count 1-s dic)
  (local (; String Number -> Number
          (define (start-with s n)
            (if (string=? 1-s (substring s 0 1))
                (add1 n) n)))
    ; - IN -
    (foldl start-with 0 dic)))
;====================================================;
