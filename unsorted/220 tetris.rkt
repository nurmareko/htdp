;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |220 tetris|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; structure definitions
(define-struct tetris [block landscape])
(define-struct block [x y])
; physical constants
(define WIDTH 10) ; # of blocks, horizontally 
(define SIZE 10) ; blocks are squares
(define SCENE-SIZE (* WIDTH SIZE))
(define SCENE
  (empty-scene SCENE-SIZE SCENE-SIZE "black"))
; graphical constants
(define BLOCK ; red squares with black rims
  (overlay
    (square (- SIZE 1) "solid" "red")
    (square SIZE "outline" "white")))

; A Tetris is a structure:
;   (make-tetris Block Landscape)

; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)

; A Block is a structure:
;   (make-block N N)

; interpretations
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting

; examples:
(define block0 (make-block (* 1 SIZE) (* 1 SIZE)))
(define block1 (make-block (* 1 SIZE) (* 10 SIZE)))
(define block2 (make-block (* 2 SIZE) (* 10 SIZE)))
(define block3 (make-block (* 2 SIZE) (* 9 SIZE)))
(define landscape0 '())
(define landscape1 (list block1))
(define landscape2 (list block1 block2))
(define landscape3 (list block1 block2 block3))
(define tetris0 (make-tetris block0 landscape0))
(define tetris1 (make-tetris block0 landscape1))
(define tetris2 (make-tetris block0 landscape2))
(define tetris3 (make-tetris block0 landscape3))
;====================================================;
; Tetris -> Image
; render current state of tetris.
(define (render s)
  (render-block (tetris-block s)
                (render-scene (tetris-landscape s))))

; Block Image -> Image
; render block on given image.
(define (render-block bl sc)
  (place-image BLOCK
               (block-x bl) (block-y bl)
               sc))

; Landscape -> Image
; render Landscape to image.
(define (render-scene li)
  (cond
    [(empty? li) SCENE]
    [else
     (render-block (first li)
                   (render-scene (rest li)))]))
;====================================================;
; tests
(check-expect
 (render tetris0)
 (render-block block0
               (render-scene landscape0)))
(check-expect
 (render tetris1)
 (render-block block0
               (render-scene landscape1)))
(check-expect
 (render tetris2)
 (render-block block0
               (render-scene landscape2)))
(check-expect
 (render tetris3)
 (render-block block0
               (render-scene landscape3)))