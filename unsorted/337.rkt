;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |337|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct file [name size content])
; A File is a structure: 
;   (make-file String N String)

; A Dir is a list:
;   (List String [List-of Dir] [List-of File])
; interpretation (define a-dir (list "TS" '() '()))
; represent a directory with
;   (first a-dir) as is name,
;   (second a-dir) as its directories, and
;   (third a-dir) as its files.
;====================================================;
; files examples
(define read!-1 (make-file "read!" 19 ""))
(define draw (make-file "draw" 2 ""))
(define hang (make-file "hang" 8 ""))
(define part3 (make-file "part3" 17 ""))
(define part2 (make-file "part2" 52 ""))
(define part1 (make-file "part1" 99 ""))
(define read!-0 (make-file "read!" 10 ""))
; directory examples
(define Docs `("Docs" () (,read!-1)))
(define Code `("code" () (,hang ,draw)))
(define Libs `("Libs" (,Code ,Docs) ()))
(define Text `("Text" () (,part1 ,part2 ,part3)))
(define TS `("TS" (,Text ,Libs) (,read!-0)))
;====================================================;
; Dir -> N
; count how many files given dir contains.

(check-expect (how-many `("Dir" () ())) 0)
(check-expect (how-many TS) 7)

(define (how-many d)
  (+ (foldr + 0 (map how-many (second d))) (length (third d))))
;====================================================;















