;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |275 v5|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
;(define LOCATION "words.txt")
;(define AS-LIST (read-lines LOCATION))
;====================================================;
; Dictionary is [NEList-of String]

; A Letter is equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz")) 

(define-struct lc [letter count])
; Letter-Counts is (make-lc 1String Number)
;====================================================;
; [NEList-of String] -> [lc 1String Number]
; produces the Letter-Count for the letter that is
; most frequently used as the first one in the words
; of the given Dictionary.

;(check-expect (most-frequent AS-LIST)
;              (make-lc "s" 22759))
(check-expect (most-frequent (list "a" "a" "a" "c" "a"))
              (make-lc "a" 4))

(define (most-frequent dic)
  (local [(define listed-lc
            (words-by-first-letter dic))]
    ; - IN -
    (argmax lc-count listed-lc)))

; [NEList-of String] -> [lc 1String Number]
; produces the Letter-Count for the letter that is
; least frequently used as the first one in the words
; of the given Dictionary.

;(check-expect (least-frequent AS-LIST)
;              (make-lc "x" 293))

;(define (least-frequent dic)
;  (local [(define listed-lc
;            (words-by-first-letter dic))]
;    ; - IN -
;    (argmin lc-count listed-lc)))
;====================================================;
; [List-of Letter] Dictionary -> [List-of Letter-Counts]
(define (words-by-first-letter dic)
  (local [; Letter -> Letter-Counts
          (define (create-lc letter)
            (make-lc letter (count-let letter)))

          ; Letter -> Number
          (define (count-let letter)
            (local [; String Number -> Number
                    (define (count s n)
                      (if (equal? letter (substring s 0 1))
                          (add1 n) n))]
              ; - IN -
              (foldr count 0 dic)))]
    ; - IN -
    (map create-lc LETTERS)))