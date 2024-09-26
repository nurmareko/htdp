;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 55|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))

; LRDC -> Image
; place rocket base on LRDC sub-class
(define (VERTICAL-POS lrdc)
  (place-image
   ROCKET 10 (- (cond
                  [(or (string? lrdc) (<= -3 lrdc -1))
                   HEIGHT]
                  [(>= lrdc 0)
                   lrdc]) CENTER) BACKG))
 
; LRDC -> Image
; create countdown if the LRDC sub-class is
; a Number between -3 and -1
(define (COUNTDOWN lrdc)
  (text (number->string lrdc) 20 "red"))

; LRDC -> Image
(define (show x)
  (cond
    [(or (string? x) (>= x 0))
     (VERTICAL-POS x)]
    [(<= -3 x -1)
     (place-image (COUNTDOWN x)
                  10 (* 3/4 WIDTH)
                  (VERTICAL-POS x))]))

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

(define (gone ws)
  (and (number? ws) (= ws 0)))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly 0.1]
    [stop-when gone]))
