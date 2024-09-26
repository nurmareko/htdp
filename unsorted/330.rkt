;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |330|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1 Dir.v1)

; A File.v1 is a String.
;=330================================================;
(define TS.v1
  '(("part1" "part2" "part3")
    "read!"
    (("hang" "draw") ("read!"))))
;=331================================================;
; Dir.v1 -> Number
; count files in dir.

(check-expect (how-many.v1 '()) 0)
(check-expect (how-many.v1 TS.v1) 7)

(define (how-many.v1 d)
  (foldr (lambda (d c) (+ c (if (string? d) 1 (how-many.v1 d)))) 0 d))

;(define (how-many d)
;  (cond
;    [(empty? d) 0]
;    [else
;     (+ (if (string? (first d)) 1 (how-many (first d)))
;        (how-many (rest d)))]))
;====================================================;
(define-struct dir [name content])
; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
 
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String.
;=332================================================;
(define Code.v2 (make-dir "Code" '("hang" "draw")))
(define Docs.v2 (make-dir "Docs" '("read!")))
(define Libs.v2 (make-dir "Libs" `(,Code.v2 ,Docs.v2)))
(define Text.v2 (make-dir "Text" '("part1" "part2" "part3")))
(define TS.v2 (make-dir "TS" `(,Text.v2 "read!" ,Libs.v2)))
;=333================================================;
; Dir.v2 -> Number
; count files in dir.

(check-expect (how-many.v2 TS.v2) 7)

(define (how-many.v2 d)
  (local (; LOFD -> Number
          (define (for-lofd d n)
            (+ n (if (string? d) 1 (how-many.v2 d)))))
    (foldr for-lofd 0 (dir-content d))))