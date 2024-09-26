;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |401|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An S-expr (S-expression) is one of: 
; – Atom
; – [List-of S-expr]
; 
; An Atom is one of: 
; – Number
; – String
; – Symbol
(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))

;====================================================;
; S-expr S-expr -> Boolean
; determines whether two S-expressions are equal

(check-expect (sexp=? 1 1) #true)
(check-expect (sexp=? "1" "1") #true)
(check-expect (sexp=? 'a 'a) #true)
(check-expect (sexp=? '(1) '(1)) #true)
(check-expect (sexp=? 1 2) #false)
(check-expect (sexp=? 1 "1") #false)
(check-expect (sexp=? "1" "2") #false)
(check-expect (sexp=? "1" 'a) #false)
(check-expect (sexp=? 'a 'b) #false)
(check-expect (sexp=? 'a  1) #false)
(check-expect (sexp=? '(1 2 3) 'a) #false)
(check-expect (sexp=? '(1 2 3) '(1 2 'a)) #false)

(define (sexp=? a b)
  (cond
    [(and (atom? a) (atom? a)) (for-atom a b)]
    [(and (list? a) (list? b))
     (if (and (empty? a) (empty? b))
         #true
         (and (sexp=? (first a) (first b))
              (sexp=? (rest a) (rest b))))]
    [else #false]))

; Atom Atom -> Boolean
(define (for-atom a b)
  (cond
    [(and (number? a) (number? b))
     (= a b)]
    [(and (string? a) (string? b))
     (string=? a b)]
    [(and (symbol? a) (symbol? b))
     (symbol=? a b)]
    [else #false]))