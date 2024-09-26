;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname mathtutordvd-link-generator) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; N  N -> String
; generate link of worksheets for the 8th grade math
; course with current unit and lessons.

;(check-expect (worksheet "1" 0) "")
;(check-expect
; (worksheet 1 1)
; "https://s3.amazonaws.com/Grade-School-Math-Worksheets/8th+Grade+Course+-+Unit+1+-+Worksheets/Eighth+Grade+Math+Course+-+Unit+1+-+Lesson+1+-+Worksheet+1.pdf
;")
;(check-expect
; (worksheet 1 2)
; "https://s3.amazonaws.com/Grade-School-Math-Worksheets/8th+Grade+Course+-+Unit+1+-+Worksheets/Eighth+Grade+Math+Course+-+Unit+1+-+Lesson+1+-+Worksheet+1.pdf
;https://s3.amazonaws.com/Grade-School-Math-Worksheets/8th+Grade+Course+-+Unit+1+-+Worksheets/Eighth+Grade+Math+Course+-+Unit+1+-+Lesson+2+-+Worksheet+2.pdf
;")
;(check-expect
; (worksheet 2 2)
; "https://s3.amazonaws.com/Grade-School-Math-Worksheets/8th+Grade+Course+-+Unit+2+-+Worksheets/Eighth+Grade+Math+Course+-+Unit+2+-+Lesson+1+-+Worksheet+1.pdf
;https://s3.amazonaws.com/Grade-School-Math-Worksheets/8th+Grade+Course+-+Unit+2+-+Worksheets/Eighth+Grade+Math+Course+-+Unit+2+-+Lesson+2+-+Worksheet+2.pdf
;")

(define (worksheet unit lesson)
  (cond
    [(zero? lesson) ""]
    [else
     (local ((define u (number->string unit))
             ;(define l (string-append "+Lesson+" (number->string lesson)))
             (define w (number->string lesson))
             (define link
               (string-append
                "https://algebra-worksheets.s3.amazonaws.com/Algebra+2+Course/Unit+" u "/Math+Tutor+-+Algebra+2+Course+-+Unit+" u "+-+Worksheet+" w ".pdf")))
       (string-append (worksheet unit (sub1 lesson))
                      link "\n"))]))

; N N -> String
; ...
(define (generate-link unit lessons)
  (write-file 'stdout (worksheet unit lessons)))