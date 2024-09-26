;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |9|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

;(define in "hello")
;(define in (square 20 "solid" "black"))
;(define in -1)
;(define in #true)
(define in #false)

(cond [(string? in) (string-length in)]
      [(image? in) (* (image-height in) (image-width in))]
      [(number? in) (abs in)]
      [(boolean? in) (if (false? in) 20 10)])