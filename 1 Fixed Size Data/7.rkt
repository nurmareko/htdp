;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |7|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define sunny #true)
(define friday #false)

(or (not sunny) friday)

; Now create an expression that computes whether sunny
; is false or friday is true. So in this particular
; case, the answer is #false. (Why?)

; because the value of (not sunny) and friday is
; #false, the "or" expression result is #false.

; How many combinations of Booleans can you associate
; with sunny and friday?

; there is 4 possible combinations.
