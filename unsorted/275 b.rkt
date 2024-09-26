;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |275 b|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
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

(define-struct LC [letter count])
; Letter-Counts is (make-LC 1String Number)
; a piece of data that combines letters and counts.

; Dictionary -> [List-of Dictionary]
; produces a list of Dictionarys, one per Letter.

(check-expect
 (words-by-first-letter (list "aa" "ab" "ba"))
 (list (list "aa" "ab") (list "ba")))

(define (words-by-first-letter dic)
  (local (; make list of Dictioanrys
          (define list-dic
            (local (; 1String [List-of String] -> [List-of String]
                    (define (group 1-s)
                      (local (; String -> Boolean
                              (define (start-w? s)
                                (string=? (substring s 0 1) 1-s)))
                        ; - IN -
                        (filter start-w? dic))))
              (map group LETTERS))))
    ; - IN -
    (remove-all empty list-dic)))
 
