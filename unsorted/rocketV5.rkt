;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocketV5) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; constants
(define ROCKET (overlay (circle 10 "solid" "green")
         (rectangle 40 4 "solid" "green"))
)
(define WIDTH 200)
(define HEIGHT 400)
(define MTSCN (/ WIDTH 2))
(define LAND-HEIGHT 10)
(define LAND (rectangle WIDTH LAND-HEIGHT "solid" "red"))
(define LAND-X (/ WIDTH 2))
(define LAND-Y (- HEIGHT (/ LAND-HEIGHT 2)))
(define ROCKET-CENTER-TO-TOP
  (- (- HEIGHT (/ (image-height ROCKET) 2)) LAND-HEIGHT))
(define ROCKET-CENTERED (/ WIDTH 2))

; functions
(define (picture-of-rocket.v5 h)
  (cond
    [(<= h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET ROCKET-CENTERED h
                  (place-image LAND LAND-X LAND-Y MTSCN))]
    [(> h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET ROCKET-CENTERED ROCKET-CENTER-TO-TOP
                  (place-image LAND LAND-X LAND-Y MTSCN))]))

; RUN > (animate picture-of-rocket.v5)