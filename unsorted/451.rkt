;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |451|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct table [length array])
; A Table is a structure:
;   (make-table N [N -> Number])
;====================================================;
(define table1 (make-table 3 (lambda (i) i)))
  
; N -> Number
(define (a2 i)
  (if (= i 0)
      pi
      (error "table2 is not defined for i =!= 0")))

(define table2 (make-table 1 a2))
;====================================================;
; Table N -> Number
; looks up the ith value in array of t
(define (table-ref t i)
  ((table-array t) i))
;====================================================;

