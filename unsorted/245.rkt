;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |245|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [Number -> Number] [Number -> Number] -> Boolean
; determines whether the two produce the same results
; for 1.2, 3, and -5.775

(check-expect (function=at1.2-3-and-5.775 add1 add1)
              #true)
(check-expect (function=at1.2-3-and-5.775 add1 sub1)
              #false)

(define (function=at1.2-3-and-5.775 a b)
  (and (= (a 1.2) (b 1.2))
       (= (a 3) (b 3))
       (= (a -5.775) (b -5.775))))