;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |198 generalize|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Los Lo1s -> Llos
; group list of string by its first letter
; base on 1String on list of 1String.
(define (group-los los lo1s)
  (cond
    [(empty? lo1s) lo1s]
    [else (cons (group-by-1s los (first lo1s))
                (group-los los (rest lo1s)))]))

; Los 1String -> Los
; filter a list of string if its first letter is not 1s
(define (group-by-1s los 1s)
  (cond
    [(empty? los) los]
    [else (if (string=? (first-str (first los)) 1s)
              (cons (first los) (group-by-1s (rest los) 1s))
              (group-by-1s (rest los) 1s))]))

; String -> 1String
; extract the first 1String from str
(define (first-str str)
  (substring str 0 1))

; tests
(define ac-dict
  (list "ass" "ama" "abba" "cool" "comas"))
(define abc
  (list "a" "b" "c"))

(check-expect (group-los ac-dict abc)
              (list (list "ass" "ama" "abba")
                    empty
                    (list "cool" "comas")))
(check-expect (group-by-1s ac-dict "a")
              (list "ass" "ama" "abba"))
(check-expect (group-by-1s ac-dict "b")
              empty)
(check-expect (group-by-1s ac-dict "c")
              (list "cool" "comas"))

