;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |453 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

(check-expect (tokenize '()) '())
(check-expect (tokenize '("a")) '("a"))
(check-expect (tokenize '("A")) '("a"))
(check-expect (tokenize (explode " a ")) '("a"))
(check-expect (tokenize (explode "a b c"))'("abc"))
(check-expect (tokenize (explode "100%"))
              '("1" "0" "0" "%"))
(check-expect (tokenize (explode "Now_Loading ..."))
              '("now" "_" "loading" "." "." "."))

;(define (tokenize aline)
;  (cond
;    [(empty? aline) '()]
;    [else
;     (cons (first-token aline)
;           (tokenize (rest-token aline)))]))

(define (tokenize aline)
  (local (;====================================================;
          (define clean-aline ; downcased aline without white space
            (explode (string-downcase (implode (filter (lambda (x) (not (string-whitespace? x))) aline)))))
          ;====================================================;
          ; Line -> [List-of Token]
          (define (tokenize-engine aline)
            (cond
              [(empty? aline) '()]
              [else
               (local ((define initial-token (first-token aline)))
                 (cons initial-token
                       (tokenize-engine (rest-aline initial-token aline))))])))
    (tokenize-engine clean-aline)))

;the problem is trivially solvable if line is '().
;
;in that case, the line doesn't contain a 1String.
;
;otherwise, line contains at least one 1String or some
;other 1String. in this case the algorithm will try to
;tokenize a sequence of one string if possible base on
;constrain, the remainderr is a new problem that the
;algorihm can solve.
;
;then, using cons to combine the initial token to the
;list of token that result from the rest of the line.
;====================================================;
; Token Line -> Line
; remove the first token from a line

(check-expect (rest-aline "now" (explode "now_loading..."))
              (explode "_loading..."))

(define (rest-aline token aline)
  (local ((define initial-sequence (explode token)))
    (remove-first-sequence initial-sequence aline)))

; [x] [List-of X] [List-of X] -> [List-of X]
; sequentially remove an item from list-b if its
; apppear on both list.

(check-expect (remove-first-sequence '() '()) '())
(check-expect (remove-first-sequence '() '("a" "b")) '("a" "b"))
(check-expect (remove-first-sequence '("a" "b") '("a" "b" "c" "d")) '("c" "d"))

(define (remove-first-sequence list-a list-b)
  (cond
    [(empty? list-a) list-b]
    [else
     (remove-first-sequence (rest list-a) (rest list-b))]))
         
;====================================================;

; [NElist-of 1String] -> Token
; get the first Token from a non-empty line.
; constraint:
; neline must not contain uppercased 1String,
; neline must not contain white space 1String.

(check-expect (first-token '("a")) "a")
(check-expect (first-token '("!")) "!")
(check-expect (first-token (explode "abc")) "abc")
(check-expect (first-token (explode "100%")) "1")
(check-expect (first-token (explode "now_loading ...")) "now")

(define (first-token neline)
  (cond
    [(empty? (rest neline)) (first neline)]
    [else
     (if (letter? (first neline))
         (first-letter neline)
         (first neline))]))

;====================================================;
; [NElist-of 1String] -> [NElist-of 1String]
; get the first sequence of letter from a non-empty line.

;(check-expect (first-letter '("a")) "a")
;(check-expect (first-letter '("a" "1")) "a")
;(check-expect (first-letter '("a" "b")) "ab")

(define (first-letter aline)
  (local (; [NElist-of 1String] -> [NElist-of 1String]
          (define (first-letter aline)
            (cond
              [(empty?  aline) '()]
              [(not (letter? (first aline))) '()]
              [else
               (cons (first aline)
                     (first-letter (rest aline)))])))
    (implode (first-letter aline))))

; Any -> Boolean
(define (letter? x)
  (member? x (explode "abcdefghijklmnopqrstuvwxyz")))
