;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 39|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define WR 10)

(define WHEEL
  (circle WR "solid" "black"))
(define LOWER-BODY
  (rectangle (* WR 7) WR "solid" "red"))  
(define MIDDLE-BODY
  (rectangle (* WR 9) WR "solid" "red"))
(define UPPER-BODY
  (rectangle (* WR 5) (* WR 2) "solid" "red"))
(define BUMPER
  (isosceles-triangle WR 270 "solid" "red"))
(define WINDOW
  (triangle (* WR 2) "solid" "red"))
(define BONNET
  (right-triangle (* WR 3) (* WR 0.5) "solid" "red"))

(define CAR (place-images
 (list WHEEL
       WHEEL
       LOWER-BODY
       MIDDLE-BODY
       UPPER-BODY
       BUMPER
       BUMPER
       WINDOW
       WINDOW
       BONNET)
 (list (make-posn (* WR 2.2) (* WR 4))
       (make-posn (* WR 8) (* WR 4))
       (make-posn (* WR 5) (* WR 3.8))
       (make-posn (* WR 5) (* WR 2.9))
       (make-posn (* WR 4) (* WR 1.7))
       (make-posn (* WR 1.2) (* WR 3.7))
       (make-posn (* WR 8.8) (* WR 3.7))
       (make-posn (* WR 1.5) (* WR 1.6))
       (make-posn (* WR 6.5) (* WR 1.6))
       (make-posn (* WR 8.1) (* WR 2.2)))
 (rectangle (* WR 10) (* WR 5) "outline" "white")))

(define BACKGROUND
  (empty-scene (* (image-width CAR) 7) (+ (image-height CAR) 5)))
(define Y-CAR
  (+ (/ (image-height CAR) 2) 2))

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
(define X-TREE
  (/ (image-width BACKGROUND) 2))
(define Y-TREE
  (- (image-height BACKGROUND) (/ (image-height TREE) 2)))


; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;(check-expect (tock 20) 23)
;(check-expect (tock 78) 81)

(define (tock ws)
  (+ ws 3))

(define (end ws)
  (> ws (- (image-width BACKGROUND) (/ (image-width CAR) 2))))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
;(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))

 (define (render cw)
   (place-images
    (list TREE
          CAR
          TREE)
    (list (make-posn (- X-TREE 100) Y-TREE)
          (make-posn cw Y-CAR)
          (make-posn X-TREE Y-TREE))
    BACKGROUND))

 (define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when end]))

 CAR
 (main 0)