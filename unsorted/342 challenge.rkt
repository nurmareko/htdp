;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |342 challenge|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)

; Dir is a structure
;  (make-dir String [List-of Dir] [List-of File])

; File is a structure
;  (make-file String N Date String)

; Date is a structure, D.
(define D (make-date 2022 1 1 1 1 1))

; Path is [List-of String]

; file examples
(define read!-0 (make-file "read!" 10 D ""))
(define part1 (make-file "part1" 99 D ""))
(define part2 (make-file "part2" 52 D ""))
(define part3 (make-file "part3" 17 D ""))
(define hang (make-file "hang" 8 D ""))
(define draw (make-file "draw" 2 D ""))
(define read!-1 (make-file "read!" 19 D ""))
; directory tree examples
(define docs (make-dir "Docs" empty (list read!-1)))
(define code (make-dir "Code" empty (list hang draw)))
(define libs (make-dir "Libs" (list code docs) empty))
(define text (make-dir "Text" empty (list part1 part2)))
(define ts (make-dir "TS" (list text libs) (list read!-0)))
;====================================================;
; Dir String -> [list-of Path]
; find path of some file with name, f, in given
; directory, d.

(check-expect (find-all (make-dir "adir" '() '()) "file.txt") #false)
(check-expect (find-all ts "part4") '())
(check-expect (find-all ts "part1") (list (list "TS" "Text" "part1")))
(check-expect (find-all ts "read!") (list (list "TS" "read!") (list "TS" "Libs" "Docs" "read!")))

;(define (find-all d f)
;  (cond
;    [(not (in-dir? d f)) #false]
;    [(in-dir? d f)
;     (... (dir-name d) ...
;      ... (dir-dirs d) ...
;      ... (dir-files d) ...)]))











