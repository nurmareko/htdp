;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |255|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] (Number -> Number)
; -> [List-of Number]
; ...
(define (map-n l f) '())

; [List-of String] (String -> String)
; -> [List-of String]
; ...
(define (map-s l f) '())
;====================================================;
; [X Y] [list-of X] (X -> Y) -> [list-of Y]
; ...
(define (abstract-map l f) '())

; [X Y] [list-of X] (X -> Y) -> [list-of Y]
; ...
(define (map1 k g)
  (cond
    [(empty? k) '()]
    [else (cons (g (first k))
                (map1 (rest k) g))]))