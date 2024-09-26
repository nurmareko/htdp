;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 51|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;    physical constants

; the radius size of the traffic light 
(define S 50)


;    graphical constants
(define RED-LIGHT
  (circle S "solid" "red"))
(define GREEN-LIGHT
  (circle S "solid" "green"))
(define YELLOW-LIGHT
  (circle S "solid" "yellow"))
; background for the traffic light
(define BG
  (circle (+ S 2) "solid" "black"))

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 
(define (main TrafficLight)
  (big-bang TrafficLight
    [to-draw render]
    [on-key next-light]))

; TraffictLight -> Image
; create a solid circle of the appropriate color base on
; TrafficLight state
(check-expect (render "red") (overlay RED-LIGHT BG))
(check-expect (render "green") (overlay GREEN-LIGHT BG))
(check-expect (render "yellow") (overlay YELLOW-LIGHT BG))
 
(define (render tl)
  (overlay (cond
    [(string=? tl "red") RED-LIGHT]
    [(string=? tl "green") GREEN-LIGHT]
    [(string=? tl "yellow") YELLOW-LIGHT])
  BG))

; TrafficLight -> TrafficLight 
; determine what color should be the next state of
; TrafficLight
;(check-expect (next-light "red") "green")
;(check-expect (next-light "green") "yellow")
;(check-expect (next-light "yellow") "red")

(define (next-light s ke)
  (cond
    [(string=? s "red") "green"]
    [(string=? s "green") "yellow"]
    [(string=? s "yellow") "red"]))

(main "red")