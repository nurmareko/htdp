;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |478|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; when the first queen is placed at the outer square
; no matter if its on the top-most row, lower-most
; row, left-most column, or right-most column the
; queen only treathen seven squares out of nine
; squares, therefore it is possible to place the
; second queen.

; when the first queen is placed at the central
; square, the queen treathen all the remaining square,
; therefore it impossible to place the second queen.