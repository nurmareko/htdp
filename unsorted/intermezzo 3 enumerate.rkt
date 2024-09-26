;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |intermezzo 3 enumerate|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [X] [List-of X] -> [List-of [List N X]]
; pairs each item in lx with its index 

(check-expect (enumerate0 '()) '())
(check-expect (enumerate0 '(a b c))
              '((1 a) (2 b) (3 c)))

(define (enumerate0 l)
  (local (; X -> [List N X]
          (define (enumerate x)
            (pair x l))
          ; X [List-of X] -> [List N X]
          (define (pair x l)
            (list (find-index x l) x))
          ; X [List-of X] -> Number
          (define (find-index x l)
            (+ (- (length l) (length (memv x l))) 1)))
    ; - IN -
    (map enumerate l)))
;====================================================;
; [List-of X] -> [List-of [List N X]]
; pairs each item in lx with its index 

(check-expect (enumerate1 '()) '())
(check-expect (enumerate1 '(a b c))
              '((1 a) (2 b) (3 c)))
 
(define (enumerate1 lx)
  (for/list ([x lx] [ith (length lx)])
    (list (+ ith 1) x)))