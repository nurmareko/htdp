;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Cartesian Products WIP|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; Math is one of:
; - Number
; - 1String

; Pair is (list Math Math)
;====================================================;
; [List-of Math] [List-of Math] -> String
; get the answer for the cartesian product of a * b.
; the answer will be a string that describe the
; set-roster notation and the number of elements.

(check-expect (cartesian-product '("a") '()) "{} The set have 0 elements.")
(check-expect (cartesian-product '() '("b")) "{} The set have 0 elements.")
(check-expect (cartesian-product '("a" 1) '(2 "b"))
              "{(a, 2), (a, b), (1, 2), (1, b)} The set have 4 elements.")

(define (cartesian-product a b)
  (local (; [List-of Math] [List-of Math] -> [List-of Pair]
          (define (cartesian-product a b)
            (foldr (lambda (x re)
                     (append (map (lambda (y) (list x y)) b) re))
                   '() a))
          ; [List-of Pair] -> String
          (define (set-roster l)
            (local (; [List X Y] -> String
                    (define (pair x)
                      (local ((define f (first x))
                              (define s (second x)))
                        (string-append
                         "(" (if (number? f) (number->string f) f)
                         ", " (if (number? s) (number->string s) s) ")"))))
              (cond
                [(empty? l) ""]
                [else
                 (if (empty? (rest l))
                     (pair (first l))
                     (string-append (pair (first l)) ", "
                                    (set-roster (rest l))))])))
          (define as-list (cartesian-product a b))
          (define counts (length as-list)))
    (string-append "{" (set-roster as-list) "} The set have " (number->string counts) " elements.")))
