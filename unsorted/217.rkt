;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |217|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define-struct body [x y direction])
; Body is a structure:
; (make-body Number Number Direction)
; represent its coordinate and its moving direction.

; Direction is:
(define DIRECTIONS
  (list "right" "left" "up" "down"))

; constants
(define TICK-RATE 0.15)
(define SIZE 100)
(define RADIUS 3)
(define DIAMETER (* RADIUS 2))
(define WIDTH SIZE)
(define HEIGHT SIZE)
(define START
  (list (make-body (/ SIZE 2) (/ SIZE 2) "right")))
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

; Segments is one of:
; - (list Body)
; - (cons Body Segments)
; examples:
(define no-tail
  (list (make-body 50 50 "left")))
(define one-tail
  (list (make-body 44 50 "left")
        (make-body 50 50 "left")))
(define two-tail
  (list (make-body 44 56 "down")
        (make-body 44 50 "left")
        (make-body 50 50 "left")))

; Number -> Segments
; main function
(define (worm-main rate)
  (big-bang two-tail
    [to-draw render]
    [on-tick tock rate]
    [on-key cardinal]))
;    [stop-when hitwall? end-scene]))

; Segments -> Image
; render image of segments
(define (render state)
  (cond
    [(empty? state) SCENE]
    [else (place-image
           WORM
           (body-x (first state))
           (body-y (first state))
           (render (rest state)))]))

; Segments -> Segments
; move segments on clock tick
(define (tock state)
  (del-last (new-head state)))
                 
; Segments -> Segments
; delete the last item on list.
(define (del-last li)
  (cond
    [(empty? (rest li)) li]
    [else (reverse (rest (reverse li)))]))

; Segments -> Segments
; add new body base on its direction
(define (new-head state)
  (cons (next-location (first state))
        state))

; Body -> Body
; create new head base on its direction
(define (next-location bod)
  (cond
    [(string=? "left" (body-direction bod))
     (make-body (- (body-x bod) DIAMETER)
                (body-y bod)
                (body-direction bod))]
    [(string=? "right" (body-direction bod))
     (make-body (+ (body-x bod) DIAMETER)
                (body-y bod)
                (body-direction bod))]
    [(string=? "up" (body-direction bod))
     (make-body (body-x bod)
                (- (body-y bod) DIAMETER)
                (body-direction bod))]
    [(string=? "down" (body-direction bod))
     (make-body (body-x bod)
                (+ (body-y bod) DIAMETER)
                (body-direction bod))]))

; Body KeyEvent -> Body
; set the moving direction
(define (cardinal state key)
  (cons (new-direction (first state) key)
        (rest state)))

; Body KeyEvent -> Body
; set the moving direction
(define (new-direction state key)
  (cond
    [(member? key DIRECTIONS)
     (make-body (body-x state)
                (body-y state)
                key)]
    [else state]))

; tests
(check-expect (render no-tail)
              (place-image WORM 50 50 SCENE))
(check-expect (render one-tail)
              (place-image WORM 44 50
                           (place-image WORM 50 50
                                        SCENE)))
(check-expect (render two-tail)
              (place-image
               WORM 44 56
               (place-image
                WORM 44 50
                (place-image
                 WORM 50 50
                 SCENE))))
(check-expect (tock no-tail)
              (list (make-body 44 50 "left")))
(check-expect (tock one-tail)
              (list (make-body 38 50 "left")
                    (make-body 44 50 "left")))
(check-expect (tock two-tail)
              (list (make-body 44 62 "down")
                    (make-body 44 56 "down")
                    (make-body 44 50 "left")))
(check-expect (del-last no-tail)
              no-tail)
(check-expect (del-last one-tail)
              (list (make-body 44 50 "left")))
(check-expect (del-last two-tail)
              (list (make-body 44 56 "down")
                    (make-body 44 50 "left")))
(check-expect (new-head no-tail)
              (list (make-body 44 50 "left")
                    (make-body 50 50 "left")))
(check-expect (new-head one-tail)
              (list (make-body 38 50 "left")
                    (make-body 44 50 "left")
                    (make-body 50 50 "left")))
(check-expect (new-head two-tail)
              (list (make-body 44 62 "down")
                    (make-body 44 56 "down")
                    (make-body 44 50 "left")
                    (make-body 50 50 "left")))
(check-expect (next-location (make-body 0 0 "left"))
                    (make-body -6 0 "left"))
(check-expect (next-location (make-body 0 0 "right"))
                    (make-body 6 0 "right"))
(check-expect (next-location (make-body 0 0 "up"))
                    (make-body 0 -6 "up"))
(check-expect (next-location (make-body 0 0 "down"))
                    (make-body 0 6 "down"))
(check-expect (cardinal no-tail "a")
              (list (make-body 50 50 "left")))
(check-expect (cardinal no-tail "left")
              (list (make-body 50 50 "left")))
(check-expect (cardinal no-tail "right")
              (list (make-body 50 50 "right")))
(check-expect (cardinal no-tail "up")
              (list (make-body 50 50 "up")))
(check-expect (cardinal no-tail "down")
              (list (make-body 50 50 "down")))
(check-expect (cardinal one-tail "left")
              (list (make-body 44 50 "left")
                    (make-body 50 50 "left")))
(check-expect (cardinal one-tail "right")
              (list (make-body 44 50 "right")
                    (make-body 50 50 "left")))
(check-expect (cardinal one-tail "up")
              (list (make-body 44 50 "up")
                    (make-body 50 50 "left")))
(check-expect (cardinal one-tail "down")
              (list (make-body 44 50 "down")
                    (make-body 50 50 "left")))
(check-expect (cardinal two-tail "left")
              (list (make-body 44 56 "left")
                    (make-body 44 50 "left")
                    (make-body 50 50 "left")))
(check-expect (cardinal two-tail "right")
              (list (make-body 44 56 "right")
                    (make-body 44 50 "left")
                    (make-body 50 50 "left")))
(check-expect (cardinal two-tail "up")
              (list (make-body 44 56 "up")
                    (make-body 44 50 "left")
                    (make-body 50 50 "left")))
(check-expect (cardinal two-tail "down")
              (list (make-body 44 56 "down")
                    (make-body 44 50 "left")
                    (make-body 50 50 "left")))
   