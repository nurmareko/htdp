;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 215-216) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define-struct body [x y direction])
; Body is a structure:
; (make-body Number Number Direction)
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
  (make-body (/ SIZE 2) (/ SIZE 2) "right"))
(define WORM
  (circle RADIUS "solid" "red"))
(define SCENE
  (empty-scene WIDTH HEIGHT "black"))
(define XY-MIN
  (+ (- SIZE SIZE) (* RADIUS 2)))
(define XY-MAX
  (- SIZE (* RADIUS 2)))
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

; Worm -> Image
; render image on current state
(define (render state)
  (place-image WORM
               (body-x state) (body-y state)
               SCENE))

; Worm -> Worm
; create new state on clock tick 
(define (tock state)
  (cond
    [(direction=? LEFT (body-direction state))
     (make-body (- (body-x state) RADIUS)
                (body-y state)
                (body-direction state))]
    [(direction=? RIGHT (body-direction state))
     (make-body (+ (body-x state) RADIUS)
                (body-y state)
                (body-direction state))]
    [(direction=? UP (body-direction state))
     (make-body (body-x state)
                (- (body-y state) RADIUS)
                (body-direction state))]
    [(direction=? DOWN (body-direction state))
     (make-body (body-x state)
                (+ (body-y state) RADIUS)
                (body-direction state))]))

; Worm KeyEvent -> Worm
; set the moving direction
(define (cardinal state key)
  (cond
    [(direction=? key LEFT)
     (make-body (body-x state) (body-y state)
      LEFT)]
    [(direction=? key RIGHT)
     (make-body (body-x state) (body-y state)
      RIGHT)]
    [(direction=? key UP)
     (make-body (body-x state) (body-y state)
      UP)]
    [(direction=? key DOWN)
     (make-body (body-x state) (body-y state)
      DOWN)]
    [else state]))

; Direction Direction -> Boolean
; is direction a equal to direction b?
(define (direction=? a b)
  (if (string=? a b) #true #false))

; Worm -> Boolean
; does worm hit wall?
(define (hitwall? state)
  (if (or (<= (body-x state) XY-MIN)
          (>= (body-x state) XY-MAX)
          (<= (body-y state) XY-MIN)
          (>= (body-y state) XY-MAX))
      #true #false))

; Worm -> Image
; end scene.
(define (end-scene state)
  (place-image END-TEXT
               TEXT-X TEXT-Y
               (render state)))

; funtional tests
(check-expect
 (render START)
 (place-image WORM
              (body-x START) (body-y START)
              SCENE))
(check-expect (tock (make-body 0 0 "left"))
                    (make-body -3 0 "left"))
(check-expect (tock (make-body 0 0 "right"))
                    (make-body 3 0 "right"))
(check-expect (tock (make-body 0 0 "up"))
                    (make-body 0 -3 "up"))
(check-expect (tock (make-body 0 0 "down"))
                    (make-body 0 3 "down"))
(check-expect
 (cardinal (make-body 0 0 "left") "left")
 (make-body 0 0 "left"))
(check-expect
 (cardinal (make-body  0 0 "left") "right")
 (make-body 0 0 "right"))
(check-expect
 (cardinal (make-body 0 0 "left") "up")
 (make-body 0 0 "up"))
(check-expect
 (cardinal (make-body 0 0 "left") "down")
 (make-body  0 0 "down"))
(check-expect
 (cardinal (make-body 0 0 "left") "a")
 (make-body 0 0 "left"))
(check-expect (hitwall? (make-body 0 10 "left"))
              #true)
(check-expect (hitwall? (make-body 100 10 "left"))
              #true)
(check-expect (hitwall? (make-body 10 0 "left"))
              #true)
(check-expect (hitwall? (make-body 0 100 "left"))
              #true)
(check-expect (hitwall? (make-body 10 10 "left"))
              #false)