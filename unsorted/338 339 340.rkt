;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |338 339 340|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

; A Path is [List-of String].
; interpretation directions into a directory tree

; folder path example
(define P "D:\\Users\\dresta\\desktop\\reading list")
; dir example
(define D (create-dir P))
; files examples
(define date0 (make-date 2022 8 31 17 26 44))
(define book (make-file "book.epub" 3000000 date0 ""))
(define video (make-file "video.mkv" 2000000 date0 ""))
(define image0 (make-file "image0.tiff" 1000000 date0 ""))
(define image1 (make-file "image1.tiff" 1500000 date0 ""))
; Directory examples
(define books (make-dir "Books" empty `(,book)))
(define movies (make-dir "Movies" empty `(,video)))
(define gallery (make-dir "Gallery" empty `(,image0 ,image1)))
(define collection (make-dir "Collection" `(,gallery ,movies ,books) empty))
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
;=340================================================;
; Dir -> [NEList-of String]
; lists names of all files and directories in d.

(check-expect (ls (make-dir "adir" '() '())) (list "adir"))
(check-expect (length (ls D)) 8)

(define (ls d)
  (append (list (dir-name d))
          (foldr append '() (map ls (dir-dirs d)))
          (map file-name (dir-files d))))
;=341================================================;
; Dir -> N
; computes the total size of all the files in the
; entire directory tree.

(check-expect (du (make-dir "adir" '() '())) 1)
(check-expect (du collection) 7500004)

(define (du d)
  (+ 1
     (foldr + 0 (map du (dir-dirs d)))
     (foldr + 0 (map file-size (dir-files d)))))