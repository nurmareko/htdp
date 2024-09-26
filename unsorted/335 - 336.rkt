;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |335 - 336|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct file [name size content])
; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir.v3 [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)
;=335================================================;
; files examples
(define read!-1 (make-file "read!" 19 ""))
(define draw (make-file "draw" 2 ""))
(define hang (make-file "hang" 8 ""))
(define part3 (make-file "part3" 17 ""))
(define part2 (make-file "part2" 52 ""))
(define part1 (make-file "part1" 99 ""))
(define read!-0 (make-file "read!" 10 ""))
; directory examples
(define Docs (make-dir.v3 "Docs" '() `(,read!-1)))
(define Code (make-dir.v3 "code" '() `(,hang ,draw)))
(define Libs (make-dir.v3 "Libs" `(,Code ,Docs) '()))
(define Text (make-dir.v3 "Text" '() `(,part1 ,part2 ,part3)))
(define TS (make-dir.v3 "TS" `(,Text ,Libs) `(,read!-0)))
;=336================================================;
; Dir.v3 -> N
; count how many files given dir contains.

(check-expect (how-many (make-dir.v3 "Dir" '() '())) 0)
(check-expect (how-many TS) 7)

(define (how-many d)
  (+ (foldr + 0 (map how-many (dir.v3-dirs d)))
     (length (dir.v3-files d))))
;====================================================;















