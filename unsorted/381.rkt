;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |381|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An XMachine is a nested list of this shape:
;   (cons 'machine (cons (cons (cons 'initial (cons FSM-State '())) '())  [List-of X1T]))
; An X1T is a nested list of this shape:
;   (cons 'action (cons (cons 'state (cons FSM-State '())) (cons 'next (cons FSM-State '()))))

<machine initial="black">
  <action state="black"    next="white" />
  <action state="white"  next="black" />
</machine>

(define xm0
  '(machine ((initial "black"))
     (action ((state "black") (next "white")))
     (action ((state "white") (next "black")))))
