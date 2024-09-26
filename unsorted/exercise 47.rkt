;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 47|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (render gauge-lvl)
  (overlay/align "middle" "bottom"
               (rectangle 10 gauge-lvl "solid" "red")
               (rectangle 11 101 "outline" "black")))

(define (tock cw)
  (cond
    [(> cw 0) (- cw 0.1)]
    [(<= cw 0) 0]))

(define (arrow cw ke)
  (cond
    [(string=? ke "up")
     (if (>= cw 100) 100 (+ cw 0.3))]
    [(string=? ke "down")
     (if (= cw 0) 0 (- cw 0.2))]))

(define (gauge-prog max)
  (big-bang max
    [to-draw render]
    [on-tick tock]
    [on-key arrow]))

