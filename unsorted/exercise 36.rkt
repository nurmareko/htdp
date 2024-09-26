;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 36|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Exercise 36. Design the function image-area, which counts
;the number of pixels in a given image.

;we use Image to represent image
;we use Number to count number of pixels.

; require "2htdp/image" teachpack
; use Number bigger than 0 
; computes the area of rectangular image.
; consume an Image and produce a Number:
; Image -> Number
; calculate img width and height to produce 0
; (define (f image) 0)
; given:
; 	820x781 Image
; expected:
; 	640420
; given:
; 	499x499 Image
; expected:
; 	249001
(require 2htdp/image)

(define (image-area img)
  (* (image-width img) (image-height img)))

(image-area (rectangle 499 499 "solid" "red"))