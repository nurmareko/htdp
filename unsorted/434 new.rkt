;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |434 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define MAX 100)

; Posn -> Posn 
; generate random posn within MAX that is guranteed
; to be distinct from the given p
; termination:
; (make-posn (random MAX) (random MAX)) will a least
; generate a new candidate than differ from p
(check-satisfied
 (food-create (make-posn 1 1)) not=-1-1?)

(define (food-create p)
  (local (; Posn Posn -> Posn 
          (define (food-check-create p candidate)
            (if (equal? p candidate) (food-create p) candidate)))
    (food-check-create p (make-posn (random MAX) (random MAX)))))

; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))
;====================================================;
;food-create
;
;when candidate not equal p, the problem is trivially
;solvable.
;
;the algorithm simply give candidate as its answer.
;
;the algorithm will generate one new problem, its
;generate new posn candidate with random x and y.
;
;when the newly generate candidate is differ from p
;then the algorithm terminate.





