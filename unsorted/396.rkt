;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |396|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An HM-Word is a [List-of Letter or "_"]
; interpretation "_" represents a letter to be guessed 

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))
;====================================================;
; Word N -> String
; runs a simplistic hangman game, produces the current state
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ; HM-Word -> HM-Word
          (define (do-nothing s) s)
          ; HM-Word KeyEvent -> HM-Word 
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status)))
    (implode
     (big-bang the-guess ; HM-Word
       [to-draw render-word]
       [on-tick do-nothing 1 time-limit]
       [on-key  checked-compare]))))
 
; HM-Word -> Image
(define (render-word w)
  (text (implode w) 22 "black"))
;====================================================;
; [List-of Letter] HM-Word Letter -> HM-Word
;  produces s with all "_" where the guess revealed
; a letter.

(check-expect (compare-word '() '() "o") '())
(check-expect (compare-word '() '("_" "_" "_") "o") '("_" "_" "_"))
(check-expect (compare-word '("d" "o" "g") '() "o") '())
(check-expect (compare-word '("d" "o" "g") '("_" "_" "_") "o") '("_" "o" "_"))
(check-expect (compare-word '("d" "o" "g") '("_" "_" "_") "a") '("_" "_" "_"))
(check-expect (compare-word '("o" "v" "o") '("_" "_" "_") "o") '("o" "_" "o"))
(check-expect (compare-word '("d" "o" "g") '("d" "_" "g") "o") '("d" "o" "g"))
(check-expect (compare-word '("d" "o" "g") '("d" "o" "g") "a") '("d" "o" "g"))

(define (compare-word w s l)
  (cond
    [(not (and (cons? w) (cons? s))) s]
    [else
     (cons (if (string=? l (first w)) (first w) (first s))
           (compare-word (rest w) (rest s) l))]))

;(define (compare-word w s l)
;  (cond
;    [(not (and (cons? w) (cons? s))) s]
;    [else
;     (if (string=? l (first w))
;          (cons (first w) (compare-word (rest w) (rest s) l))
;          (cons (first s) (compare-word (rest w) (rest s) l)))]))

;(define (compare-word w s l)
;  (cond
;    [(and (empty? w) (empty? s))
;     s]
;    [(and (empty? w) (cons? s))
;     s]
;    [(and (cons? w) (empty? s))
;     s]
;    [(and (cons? w) (cons? s))
;     (if (string=? l (first w))
;          (cons (first w) (compare-word (rest w) (rest s) l))
;          (cons (first s) (compare-word (rest w) (rest s) l)))]))

;(define (compare-word w s l)
;  (cond
;    [(and (empty? w) (empty? s))
;     ...]
;    [(and (empty? w) (cons? s))
;     ...]
;    [(and (cons? w) (empty? s))
;     ...]
;    [(and (cons? w) (cons? s))
;     ( ... (first w) ... (rest w) ...
;       ... (first s) ... (rest s) ...)]))
;====================================================;
;(define LOCATION "words.txt")
;(define AS-LIST (read-lines LOCATION))
;(define SIZE (length AS-LIST))
;(play (list-ref AS-LIST (random SIZE)) 10)