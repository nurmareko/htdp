;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |453 as one|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Line is a [List-of 1String].

; A Token is one of:
; - 1String
; - String
; constraint:
; consists of lower-case letters and nothing else.
; That is, all white-space 1Strings are dropped; all
; other non-letters remain as is; and all consecutive
; letters are bundled into “words.”
;====================================================;
; Line -> [List-of Token]
; convert a line into a list of tokens

;(check-expect (tokenize '()) '())
;(check-expect (tokenize '("a")) '("a"))
;(check-expect (tokenize '("A")) '("a"))
;(check-expect (tokenize (explode " a ")) '("a"))
;(check-expect (tokenize (explode "a b c"))'("abc"))
;(check-expect (tokenize (explode "100%"))
;              '("1" "0" "0" "%"))
(check-expect (tokenize (explode "Now_Loading ...")) ; 446 step
              '("now" "_" "loading" "." "." "."))

;(check-expect (tokenize '()) '())
;(check-expect (tokenize '("a" "b" "c")) '("abc"))
;(check-expect (tokenize '("A" "B" "C")) '("abc"))
;(check-expect (tokenize '(" " "b" " ")) '("b"))
;(check-expect (tokenize '("a" "b" "1" "c")) '("ab" "1" "c"))
;(check-expect (tokenize '("H" "e" "l" "l" "o" "." " " "W" "o" "r" "l" "d"))
;              '("hello" "." "world"))

(define (tokenize aline)
  (local ((define clean-aline
            (filter (lambda (s) (not (string-whitespace? s))) (map string-downcase aline)))
          ; [NElist-of 1String] -> Token
          (define (first-token neline)
            (cond
              [(empty? (rest neline)) (first neline)]
              [else
               (local (; [NElist-of 1String] -> [NElist-of 1String]
                       (define (first-letter aline)
                         (local (; [NElist-of 1String] -> [NElist-of 1String]
                                 (define (first-letter aline)
                                   (cond
                                     [(empty?  aline) '()]
                                     [(not (string-alphabetic? (first aline))) '()]
                                     [else
                                      (cons (first aline)
                                            (first-letter (rest aline)))])))
                           (implode (first-letter aline)))))
                 (if (string-alphabetic? (first neline))
                     (first-letter neline)
                     (first neline)))]))
          ; Token Line -> Line
          (define (rest-aline token aline)
            (local ((define initial-sequence (explode token))
                    ; [x] [List-of X] [List-of X] -> [List-of X]
                    (define (rest-aline list-a list-b)
                      (cond
                        [(empty? list-a) list-b]
                        [else
                         (rest-aline (rest list-a) (rest list-b))])))
              (rest-aline initial-sequence aline)))
          ; Line -> [List-of Token]
          (define (tokenize aline)
            (cond
              [(empty? aline) '()]
              [else
               (local ((define initial-token (first-token aline)))
                 (cons initial-token
                       (tokenize (rest-aline initial-token aline))))])))
    (tokenize clean-aline)))