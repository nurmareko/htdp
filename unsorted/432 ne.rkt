;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |432 ne|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define MAX 100)

; Posn -> Posn 
; generate random posn within MAX that is guranteed
; to be distinct from the given p
(check-satisfied
 (food-create (make-posn 1 1)) not=-1-1?)

(define (food-create p)
  (local ((define CANDIDATE (make-posn (random MAX) (random MAX)))
          ; Posn -> Posn
          (define (food-create p)
            (if (equal? p CANDIDATE) (food-create p) CANDIDATE)))  
    (food-create p)))
 

; generative recursion 
; is p equal candidate?
; if yes generate new new candidate
; else given current candidate


; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))