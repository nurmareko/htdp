;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |400|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; a DNA is one of: 
; - 'a 
; - 'c 
; - 'g 
; - 't

;====================================================;
; [List-of DNA] [List-of DNA] -> Boolean
; returns #true if the pattern, p, is identical to
; the initial part of the search string, ss.

(check-expect (DNAprefix '() '()) #true)
(check-expect (DNAprefix '() '(a)) #false)
(check-expect (DNAprefix '(a) '()) #false)
(check-expect (DNAprefix '(a) '(a)) #true)

(check-expect (DNAprefix '(a c g t) '(a c g t)) #true)
(check-expect (DNAprefix '(a c g t) '(a c g t a)) #true)
(check-expect (DNAprefix '(a c g t) '(a a c g t)) #false)
(check-expect (DNAprefix '(a c g t) '(a c g)) #false)

(define (DNAprefix p ss)
  (cond
    [(and (empty? p) (empty? ss))
     #true]
    [(and (empty? p) (cons? ss))
     #false]
    [(and (empty? (rest p)) (cons? ss))
     #true]
    [(and (cons? p) (empty? ss))
     #false]
    [(and (cons? p) (cons? ss))
     (and (equal? (first p) (first ss))
      (DNAprefix (rest p) (rest ss)))]))

;(define (DNAprefix p ss)
;  (cond
;    [(and (empty? p) (empty? ss))
;     #true]
;    [(and (empty? p) (cons? ss))
;     #false]
;    [(and (empty? (rest p)) (cons? ss))
;     #true]
;    [(and (cons? p) (empty? ss))
;     #false]
;    [(and (cons? p) (cons? ss))
;     (and (equal? (first p) (first ss))
;      (DNAprefix (rest p) (rest ss)))]))

;(define (DNAprefix p ss);  (cond
;    [(and (empty? p) (empty? ss))
;     #true]
;    [(and (empty? p) (cons? ss))
;     #false]
;    [(and (cons? p) (empty? ss))
;     #false]
;    [(and (cons? p) (cons? ss))
;     (... (first p) ... (first ss) ...
;      ... (rest p) ... (rest ss) ...)]))

;(define (DNAprefix p ss)
;  (cond
;    [(and (empty? p) (empty? ss))
;     ...]
;    [(and (empty? p) (cons? ss))
;     ...]
;    [(and (cons? p) (empty? ss))
;     ...]
;    [(and (cons? p) (cons? ss))
;     ...]
;====================================================;
; [List-of DNA] [List-of DNA] -> DNA
; returns the first item in the search string beyond
; the pattern

(check-error (DNAdelta '() '()))
(check-expect (DNAdelta '() '(a)) #false)
(check-expect (DNAdelta '(a) '()) #false)
(check-error (DNAdelta '(a) '(a)))
(check-expect (DNAdelta '(a c g t) '(a c g t a)) 'a)
(check-expect (DNAdelta '(a a c g t) '(a c g t)) #false)

(define (DNAdelta p ss)
  (cond
    [(and (empty? p) (empty? ss)) (error "error")]
    [(and (empty? p) (cons? ss)) #false]
    [(and (cons? p) (empty? ss)) #false]
    [(and (cons? p) (cons? ss))
     (if (and (equal? (first p) (first ss)) (empty? (rest p)))
         (second ss)
         (DNAdelta (rest p) (rest ss)))]))

;(define (DNAprefix p ss)
;  (cond
;    [(and (empty? p) (empty? ss)) ...]
;    [(and (empty? p) (cons? ss)) ...]
;    [(and (cons? p) (empty? ss)) ...]
;    [(and (cons? p) (cons? ss))
;     (... (first p) ... (first ss) ...
;      ... (rest p) ... (rest ss) ...)]))