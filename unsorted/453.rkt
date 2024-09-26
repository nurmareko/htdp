;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |453|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define NEWLINE "\n") ; the 1String

; A File is one of: 
; – '()
; – (cons "\n" File)
; – (cons 1String File)
; interpretation represents the content of a file 
; "\n" is the newline character

; A Line is a [List-of 1String].

; A Token is noe of:
; - 1String
; - String
; Constrains A Token consist of lower-case letters
; and nothing else. That is,
; - all white-space 1Strings are dropped
; - all other non-letters remain as is
; - all consecutive letters are bundled into “words.”
;====================================================;
; Line -> [List-of Token]
; convert Line into List of Token.

;(check-expect (tokenize '()) '())
;(check-expect (tokenize '("a" "b" "c")) '("abc"))
;(check-expect (tokenize '("A" "B" "C")) '("abc"))
;(check-expect (tokenize '(" " "b" " ")) '("b"))
;(check-expect (tokenize '("a" "b" "1" "c")) '("ab" "1" "c"))
;(check-expect (tokenize '("H" "e" "l" "l" "o" "." " " "W" "o" "r" "l" "d"))
;              '("hello" "." "world"))
;
;(check-expect (tokenize '()) '())
;(check-expect (tokenize '("a")) '("a"))
;(check-expect (tokenize '("A")) '("a"))
;(check-expect (tokenize (explode " a ")) '("a"))
;(check-expect (tokenize (explode "a b c"))'("abc"))
;(check-expect (tokenize (explode "100%"))
;              '("1" "0" "0" "%"))
(check-expect (tokenize (explode "Now_Loading ...")) ; 486 step
              '("now" "_" "loading" "." "." "."))

(define (tokenize l)
  (local ((define clean-aline (filter (lambda (s) (not (string-whitespace? s))) (map string-downcase l)))
          ; Line -> [List-of Token]
          (define (bundle l)
            (local (; [NEList-of 1String] -> String
                    (define (first-word l)
                      (cond
                        [(empty? (rest l)) (first l)]
                        [(not (string-alphabetic? (first l))) ""]
                        [else
                         (string-append (first l)
                                        (first-word (rest l)))]))
                    ; Line -> Line
                    (define (remove-first-bundle l)
                      (cond
                        [(empty? l) '()]
                        [(and (not (empty? (rest l))) (not (string-alphabetic? (second l)))) (rest l)]
                        [else
                         (if (string-alphabetic? (first l))
                             (remove-first-bundle (rest l))
                             (rest l))])))
              (cond
                [(empty? l) '()]
                [else
                 (cons (if (string-alphabetic? (first l))
                           (first-word l)
                           (first l))
                       (bundle (remove-first-bundle l)))]))))
    (bundle clean-aline)))