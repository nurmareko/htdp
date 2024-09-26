;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocketV3) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

(place-image (square 10 "solid" "red") 50 (- 60 (/ (image-height (square 10 "solid" "red"))2))
             (empty-scene 100 60))