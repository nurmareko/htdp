;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |338|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
 (require htdp/dir)

; folder path example
(define P "D:\\Users\\dresta\\desktop\\reading list")
; dir example
(define D (create-dir P))
;=338================================================;
; Dir -> N
; count how many files given dir contains.

(check-expect (how-many (make-dir "Dir" '() '())) 0)
(check-expect (how-many D) 6)

(define (how-many d)
  (+ (foldr + 0 (map how-many (dir-dirs d)))
     (length (dir-files d))))
;=339================================================;
; Dir String -> Boolean
; is a File with name, fn, occurs in Dir, d?

(check-expect (find? (make-dir "Dir" '() '()) "file.txt") #false)
(check-expect (find? D "file.txt") #false)
(check-expect (find? D "MY_PRAYER_BOOKLET.pdf") #true)
(check-expect (find? D "decoy.txt") #true)

;(define (find? d fn)
;  (local (; Dir -> Boolean
;          (define (for-dir d)
;            (or (for-dirs (dir-dirs d)) (for-files (dir-files d))))
;          ; [List-of Dir] -> Boolean
;          (define (for-dirs ld) (ormap for-dir ld))
;          ; [List-of File] -> Boolean
;          (define (for-files lf)
;            (ormap (lambda (f) (string=? fn f)) (map file-name lf))))
;  (for-dir d)))

(define (find? d fn)
  (or (ormap (lambda (d) (find? d fn)) (dir-dirs d))
      (ormap (lambda (f) (string=? fn f)) (map file-name (dir-files d)))))
;====================================================;
; Dir -> [NEList-of String]
; lists names of all files and directories in d.

(check-expect (ls (make-dir "adir" '() '())) (list "adir"))
(check-expect (length (ls D)) 8)

(define (ls d)
  (append (list (dir-name d))
          (foldr append '() (map ls (dir-dirs d)))
          (map file-name (dir-files d))))