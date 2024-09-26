;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |387|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Symbol] [List-of Number]
; ->
; [List-of [List Symbol Number]]
; produces all possible ordered pairs of symbols
; and numbers

(check-expect (cross '() '()) '())
(check-expect (cross '() '(1)) '())
(check-expect (cross '(a) '()) '())
(check-expect (cross '(a) '(1)) '((a 1)))
(check-expect
 (cross '(a b c) '(1 2))
 '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))

(define (cross ls ln)
  (foldr (lambda (s b)
           (append (map (lambda (n) (list s n)) ln) b))
         '() ls))

;(define (cross ls ln)
;  (cond
;    [(empty? ls) '()]
;    [else
;     (append (map (lambda (n) (list (first ls) n)) ln)
;             (cross (rest ls) ln))]))

;(define (cross ls ln)
;  (cond
;    [(empty? ls) '()]
;    [else
;     (local (; [List-of Number] Symbol -> [list-of [Pair Symbol Number]]
;             (define (fun ln s)
;               (cond
;                 [(empty? ln) '()]
;                 [else
;                  (cons (list s (first ln))
;                        (fun (rest ln) s))])))
;       (append (fun ln (first ls))
;               (cross (rest ls) ln)))]))