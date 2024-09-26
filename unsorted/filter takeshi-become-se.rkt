;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |filter takeshi-become-se|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [List- of String] -> [List-of String]
; produces a list from those items on lx for which
; value is "sex".
(define (takeshi-become-sex lx)
  (local [; String -> Boolean
          ; is str equal "sex"?
          (define (sex? str)
            (string=? str "sex"))]
    (filter sex? lx)))

; [List- of String] -> [List-of String]
; produces a version of lx that is sorted which
; "takkeshi" come first
(define (takeshi-before-sex lx)
  (local [; String String -> Boolean
          ; is takeshi come first?
          (define (takeshi-first a b)
            (string>=? a b))]
  (sort lx takeshi-first)))

(define takeshi
  (list "takeshi"
        "sex"
        "takeshi"
        "sex"
        "takeshi"
        "sex"
        "takeshi"
        "sex"
        "takeshi"
        "sex"))
(define sex
  (list "sex"
        "sex"
        "sex"
        "sex"
        "sex"))
(check-expect (takeshi-become-sex takeshi)
              sex)
(check-expect (takeshi-before-sex takeshi)
              (list
               "takeshi"
               "takeshi"
               "takeshi"
               "takeshi"
               "takeshi"
               "sex"
               "sex"
               "sex"
               "sex"
               "sex"))