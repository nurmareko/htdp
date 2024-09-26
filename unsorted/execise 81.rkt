;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |execise 81|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(check-expect (time->seconds (make-time 0 0 45)) 45)
(check-expect (time->seconds (make-time 0 4 0)) 240)
(check-expect (time->seconds (make-time 7 0 0)) 25200)
(check-expect (time->seconds (make-time 0 0 0)) 0)

(define-struct time [hour minute second])

(define (time->seconds t)
  (+ (* 60 (+ (* 60 (time-hour t)) (time-minute t))) (time-second t)))