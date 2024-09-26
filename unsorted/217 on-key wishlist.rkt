;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |217 on-key wishlist|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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

; Worm KeyEvents -> Worm
; control worm moving direction.
(check-expect
 (director (make-worm L (list (make-posn 50 50)))
           "left")
 (make-worm L (list (make-posn 50 50))))
(check-expect
 (director (make-worm L (list (make-posn 50 50)))
           "right")
 (make-worm R (list (make-posn 50 50))))
(check-expect
 (director (make-worm L (list (make-posn 50 50)))
           "up")
 (make-worm U (list (make-posn 50 50))))
(check-expect
 (director (make-worm L (list (make-posn 50 50)))
           "down")
 (make-worm D (list (make-posn 50 50))))
(check-expect
 (director (make-worm L (list (make-posn 50 50)))
           "a")
 (make-worm L (list (make-posn 50 50))))

(define (director s ke)
  (cond [(member? ke DIRECTIONS)
         (make-worm ke (worm-tail s))]
        [else s]))