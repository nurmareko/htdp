;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |215|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define-struct worm [posn direction])
; Worm is a structure:
; (make-worm (make-posn Number Number) Direction)
; represent its coordinate and its moving direction.

; Direction is one of:
(define LEFT "left")
(define RIGHT "right")
(define UP "up")
(define DOWN "down")

; constants
(define TICK-RATE 0.07)
(define SIZE 100)
(define RADIUS 3)
(define WIDTH SIZE)
(define HEIGHT SIZE)
(define START
  (make-worm (make-posn (/ SIZE 2) (/ SIZE 2))
             "right"))
(define WORM
  (circle RADIUS "solid" "red"))
(define SCENE
  (empty-scene WIDTH HEIGHT "black"))
(define EDGE-LT
  (- SIZE SIZE))
(define EDGE-RB
  SIZE)
(define END-TEXT
  (text "worm hit wall" 10 "white"))
(define TEXT-X
  (/ SIZE 2))
(define TEXT-Y
  (/ SIZE 2))

; Number -> Worm
; main function
(define (worm-main rate)
  (big-bang START
    [to-draw render]
    [on-tick tock rate]
    [on-key cardinal]
    [stop-when hitwall? end-scene]))

; Worm -> Worm
; render image on current state
(define (render state)
  (place-image WORM
               (posn-x (worm-posn state))
               (posn-y (worm-posn state))
               SCENE))

; Worm -> Worm
; create new state on clock tick 
(define (tock state)
  (cond
    [(direction=? LEFT (worm-direction state))
     (make-worm
      (make-posn (- (posn-x (worm-posn state)) RADIUS)
                 (posn-y (worm-posn state)))
      (worm-direction state))]
    [(direction=? RIGHT (worm-direction state))
     (make-worm
      (make-posn (+ (posn-x (worm-posn state)) RADIUS)
                 (posn-y (worm-posn state)))
      (worm-direction state))]
    [(direction=? UP (worm-direction state))
     (make-worm
      (make-posn (posn-x (worm-posn state)) 
                 (- (posn-y (worm-posn state)) RADIUS))
      (worm-direction state))]
    [(direction=? DOWN (worm-direction state))
     (make-worm
      (make-posn (posn-x (worm-posn state)) 
                 (+ (posn-y (worm-posn state)) RADIUS))
      (worm-direction state))]))

; Worm -> Worm
; set the moving direction
(define (cardinal state key)
  (cond
    [(direction=? key LEFT)
     (make-worm
      (make-posn (posn-x (worm-posn state)) (posn-y (worm-posn state)))
      LEFT)]
    [(direction=? key RIGHT)
     (make-worm
      (make-posn (posn-x (worm-posn state)) (posn-y (worm-posn state)))
      RIGHT)]
    [(direction=? key UP)
     (make-worm
      (make-posn (posn-x (worm-posn state)) (posn-y (worm-posn state)))
      UP)]
    [(direction=? key DOWN)
     (make-worm
      (make-posn (posn-x (worm-posn state)) (posn-y (worm-posn state)))
      DOWN)]
    [else state]))

; Direction Direction -> Boolean
; is direction a equal to direction b?
(define (direction=? a b)
  (if (string=? a b) #true #false))

; Worm -> Boolean
; does worm hit wall?
(define (hitwall? state)
  (if (or (<= (posn-x (worm-posn state)) EDGE-LT)
          (>= (posn-x (worm-posn state)) EDGE-RB)
          (<= (posn-y (worm-posn state)) EDGE-LT)
          (>= (posn-y (worm-posn state)) EDGE-RB))
      #true #false))

; Worm -> Image
; end scene
(define (end-scene state)
  (place-image END-TEXT
               TEXT-X TEXT-Y
               (render state)))
               

; funtional tests
(check-expect
 (render START)
 (place-image WORM
              (posn-x (worm-posn START)) (posn-y (worm-posn START))
              SCENE))
(check-expect (tock (make-worm (make-posn 0 0) "left"))
                    (make-worm (make-posn -3 0) "left"))
(check-expect (tock (make-worm (make-posn 0 0) "right"))
                    (make-worm (make-posn 3 0) "right"))
(check-expect (tock (make-worm (make-posn 0 0) "up"))
                    (make-worm (make-posn 0 -3) "up"))
(check-expect (tock (make-worm (make-posn 0 0) "down"))
                    (make-worm (make-posn 0 3) "down"))
(check-expect
 (cardinal (make-worm (make-posn 0 0) "left") "left")
 (make-worm (make-posn 0 0) "left"))
(check-expect
 (cardinal (make-worm (make-posn 0 0) "left") "right")
 (make-worm (make-posn 0 0) "right"))
(check-expect
 (cardinal (make-worm (make-posn 0 0) "left") "up")
 (make-worm (make-posn 0 0) "up"))
(check-expect
 (cardinal (make-worm (make-posn 0 0) "left") "down")
 (make-worm (make-posn 0 0) "down"))
(check-expect
 (cardinal (make-worm (make-posn 0 0) "left") "a")
 (make-worm (make-posn 0 0) "left"))
(check-expect (hitwall? (make-worm (make-posn 0 10) "left"))
              #true)
(check-expect (hitwall? (make-worm (make-posn 100 10) "left"))
              #true)
(check-expect (hitwall? (make-worm (make-posn 10 0) "left"))
              #true)
(check-expect (hitwall? (make-worm (make-posn 10 100) "left"))
              #true)
(check-expect (hitwall? (make-worm (make-posn 10 10) "left"))
              #false)
