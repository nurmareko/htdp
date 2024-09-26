;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |175 v5|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "words.txt")
(define AS-LIST (read-lines LOCATION))
;====================================================;
; Dictionary is [NEList-of String]

; A Letter is equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz")) 

(define-struct lc [letter count])
; Letter-Counts is (make-lc 1String Number)
;====================================================;
; [NEList-of String] -> [lc 1String Number]
(define (most-frequent dic) ...)

; [NEList-of String] -> [lc 1String Number]
(define (least-frequent dic) ...)