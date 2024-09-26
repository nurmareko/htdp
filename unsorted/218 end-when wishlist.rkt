;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |218 end-when wishlist|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; constants
(define L "left")
(define R "right")
(define U "up")
(define D "down")
(define TICK-RATE 0.1)
(define SIZE 200)
(define RADIUS 3)
(define DIAMETER (* RADIUS 2))
(define WIDTH SIZE)
(define HEIGHT SIZE)
(define START-POSN
  (make-posn (/ SIZE 4) (/ SIZE 2)))
(define HEAD
  (list START-POSN))
(define WORM
  (circle RADIUS "solid" "red"))
(define SCENE
  (empty-scene WIDTH HEIGHT "black"))
(define MIN
  (+ (- SIZE SIZE) (* RADIUS 2)))
(define MAX
  (- SIZE (* RADIUS 2)))
(define END-TEXT
  (text "worm hit wall" 10 "white"))
(define TEXT-X
  (/ SIZE 2))
(define TEXT-Y
  (/ SIZE 2))

(define-struct worm [ d tail])
; Worm is:
; (make-worm Direction Tail)
(define START
  (make-worm "right" HEAD))

; Direction is one of: 
; – L
; – R 
; – U
; - D
; or, equivalently, a member? of this list: 
(define DIRECTIONS
  (list L R U D))

; Tail is a list of Posn:
; - (list Posn)
; - (list Posn Tail)

; Posn -> Boolean
; is head hit wall?
(check-expect (hit-wall? (make-posn MIN 50)) #true)
(check-expect (hit-wall? (make-posn MAX 50)) #true)
(check-expect (hit-wall? (make-posn 50 MIN)) #true)
(check-expect (hit-wall? (make-posn 50 MAX)) #true)
(check-expect (hit-wall? (make-posn 10 50)) #false)

(define (hit-wall? pos)
  (if (or (<= (posn-x pos) MIN)
          (>= (posn-x pos) MAX)
          (<= (posn-y pos) MIN)
          (>= (posn-y pos) MAX))
  #true #false))

; Tail -> Boolean
; is head hit body?
(check-expect (hit-body? (list (make-posn 50 50)
                               (make-posn 56 50)))
                         #false)
(check-expect (hit-body? (list (make-posn 50 50)
                               (make-posn 50 50)))
                         #true)

(define (hit-body? s)
  (if (member? (first s) (rest s))
     #true #false))

; Worm -> Boolean
; is head hit wall/body?
(check-expect (hit-wall/body? (make-worm "left" (list (make-posn 0 50))))
              #true)
(check-expect (hit-wall/body? (make-worm "left" (list (make-posn 10 50))))
              #false)

(define (hit-wall/body? s)
  (if (or (hit-wall? (first (worm-tail s)))
          (hit-body? (worm-tail s)))
      #true #false))
         