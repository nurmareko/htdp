;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 215.v2) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define-struct worm [ d tail])
; Worm is:
; (make-worm Direction Tail)

; Direction is one of the following Strings: 
; – "left"
; – "right 
; – "up"
; - "down"
; or, equivalently, a member? of this list: 
(define DIRECTIONS
  (list "left" "right" "up" "down"))

; Tail is a list of Posn:
; - (list Posn)
; - (list Posn Tail)

; constants
(define TICK-RATE 0.07)
(define SIZE 200)
(define RADIUS 3)
(define WIDTH SIZE)
(define HEIGHT SIZE)
(define HEAD
  (make-posn (/ SIZE 4) (/ SIZE 2)))
(define START
  (make-worm "right" HEAD))
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

; Posn examples:
(define tail1
  (make-posn (- (/ SIZE 4) 6) (/ SIZE 2)))
(define tail2
  (make-posn (- (/ SIZE 4) 6) (- (/ SIZE 2) 6)))

; Tail examples:
(define head
  (list HEAD))
(define one-tail
  (list HEAD tail1))
(define two-tail
  (list HEAD tail1 tail2))

; Worm examples:
(define worm1
  (make-worm "right" head))
(define worm2
  (make-worm "right" one-tail))
(define worm3
  (make-worm "right" two-tail))




