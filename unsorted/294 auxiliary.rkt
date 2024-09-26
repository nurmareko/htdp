;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |294 auxiliary|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; Number [List-of X] -> [Maybe [NEList-of X]]
; produces the suffix of the list that starts with item at index n
; if not, it produces false. 

(check-expect (memv-indx 1 '()) #false)
(check-expect (memv-indx 10 '(1 2 3)) #false)
(check-expect (memv-indx 1 (list 1 0 1 0)) (list 0 1 0))

(define (memv-indx n lx)
  (cond
    [(or (empty? lx) (> (add1 n) (length lx))) #false]
    [(zero? n) lx]
    [else (memv-indx (sub1 n) (rest lx))]))