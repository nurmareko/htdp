;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |254|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] (Number Number -> Boolean)
; -> [List-of Number]
; produces a sorted list of numbers from l.
(define (sort-n l f) '())

; [List-of String] (String String -> Boolean)
; -> [List-of String]
; produces a sorted list of strings from l.
(define (sort-s l f) '())
;====================================================;
; [X Y] [List-of X] (X X -> Y) -> [List-of X]
; ...
(define (abs-sort l f) '())

; [List-of IR] (IR IR -> Boolean) -> [List-of IR]
; ...
(define (sort-ir l f) '())