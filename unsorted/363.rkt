;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |363|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An Xexpr.v2 is:
;  (cons Symbol Body)

; A Body is one of:
; - [List-of Xexpr.v2]
; - (cons [List-of Attribute] [List-of Xexpr.v2])

; An Attribute is:
;  (list Symbol String)
;=364================================================;
;'(transition ((from "seen-e") (to "seen-f")))
;'(ul (li (word) (word)) (li (word)))
;====================================================;