;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |398|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [List-of Number] -> Number
; produces the value of the combination for these values.

(check-expect (value '() '()) 0)
(check-expect (value '(5) '(10)) 50)
(check-expect (value '(5 17) '(10 1)) 67)
(check-expect (value '(5 17 3) '(10 1 2)) 73)

(define (value lc vv)
  (cond
    [(empty? lc) 0]
    [else
     (+ (* (first lc) (first vv))
        (value (rest lc) (rest vv)))]))

;(define (value lc vv)
;  (cond
;    [(empty? lc) '()]
;    [else
;     ( ... (first lc) ... (first vv) ....
;       ... (value (rest lc) (rest vv) ...))]))