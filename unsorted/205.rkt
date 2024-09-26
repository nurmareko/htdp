;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |205|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define ITUNES-LOCATION "iTunes Music Library.xml")

; Date example
(define date
  (create-date 2022 8 29 3 16 30))

; Association examples
(define assoc-boolean
  (cons "boo" (cons #false '())))
(define assoc-num
  (cons "num" (cons 0 '())))
(define assoc-str
  (cons "str" (cons "a" '())))
(define assoc-date
  (cons "dat" (cons date '())))

; LAssoc examples
(define la
  (list assoc-boolean
        assoc-num
        assoc-str
        assoc-date))

;  LLists examples
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))
(define trax-list
  (list la))

; String LAsocc Any -> Any
;  produces the first Association whose first item is
; equal to key, or default if there is no such
; Association.
(define (find-association key list default)
  (cond
    [(empty? list) default]
    [else
     (if (equal? key (first (first list)))
         (first list)
         (find-association key (rest list) default))]))

; tests
(check-expect (find-association "num" la "what")
              assoc-num)
(check-expect (find-association "nonuplex" la "what")
              "what")
(check-expect
 (find-association "nonuplex" empty "what")
 "what")
(check-expect
 (find-association "num" empty "what")
              "what")