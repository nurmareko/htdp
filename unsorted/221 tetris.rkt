;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |221 tetris|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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
(define block0 (make-block (* 0 SIZE) (* 0 SIZE)))
(define block1 (make-block (* 0 SIZE) (* 10 SIZE)))
(define block2 (make-block (* 1 SIZE) (* 10 SIZE)))
(define block3 (make-block (* 1 SIZE) (* 9 SIZE)))
(define landscape0 '())
(define landscape1 (list block1))
(define landscape2 (list block1 block2))
(define landscape3 (list block1 block2 block3))
(define tetris0 (make-tetris block0 landscape0))
(define tetris1 (make-tetris block0 landscape1))
(define tetris2 (make-tetris block0 landscape2))
(define tetris3 (make-tetris block0 landscape3))
;===================================================;
; Number -> Tetris
; tetris main function
; use clock tick rate as input
(define (tetris-main rate)
  (big-bang (make-tetris (block-generate WIDTH) '())
    [to-draw render]
    [on-tick tock rate]
    [on-key control]))

; Number -> Block
; generate block with random x base on the given n.
(define (block-generate n)
  (make-block (* (random (+ WIDTH 1)) SIZE)
              (* 0 SIZE)))
;===================================================;
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
;===================================================;
; Tetris -> Tetris
; drop block on clock tick.
(define (tock s)
  (if (or (on-floor? s) (on-top? s))
      (make-tetris (block-generate WIDTH)
                   (cons (tetris-block s)
                         (tetris-landscape s)))
      (make-tetris (drop-block (tetris-block s))
                   (tetris-landscape s))))

; Block -> Block
; drop block on clock tick.
(define (drop-block bl)
  (make-block (block-x bl)
              (+ (block-y bl) SIZE)))

; Tetris -> Boolean
; is block reach floor?
(define (on-floor? s)
  (if (= (block-y (tetris-block s)) SCENE-SIZE)
      #true #false))

; Tetris -> Boolean
; is block reach landscape?
(define (on-top? s)
  (if (member? (drop-block (tetris-block s))
               (tetris-landscape s))
  #true #false))
;===================================================;
; Tetris KeyEvent -> Tetris
; control droping block when possible.
(define (control s ke)
  (if (not (or (on-edge? (tetris-block s) ke)
               (block-on-side? s ke)))
      (make-tetris (move-block (tetris-block s) ke)
                   (tetris-landscape s))
      s))

; Block KeyEvent -> Block
; move block on keyevent "left" or "right".
(define (move-block bl ke)
  (cond [(string=? "left" ke)
         (make-block (- (block-x bl) SIZE)
                     (block-y bl))]
        [(string=? "right" ke)
         (make-block (+ (block-x bl) SIZE)
                     (block-y bl))]
        [else bl]))

; Block KeyEvent -> Boolean
; is block on the edge of scene?
(define (on-edge? bl ke)
  (or (and (= (block-x bl) 0)
           (string=? "left" ke))
      (and (= (block-x bl) SCENE-SIZE)
           (string=? "right" ke))))

; Tetris KeyEvent -> Boolean
; is there any landscape blocks on the side of block?
(define (block-on-side? s ke)
  (member? (move-block (tetris-block s) ke)
           (tetris-landscape s)))
;===================================================;
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
(check-random
 (block-generate WIDTH)
 (make-block (* (random (+ WIDTH 1)) SIZE)
             (* 0 SIZE)))
(check-random
 (tock
  (make-tetris (make-block (* 0 SIZE) (* 9 SIZE))
               landscape1))
  (make-tetris
   (block-generate WIDTH)
   (list (make-block (* 0 SIZE) (* 9 SIZE))
         block1)))
(check-expect
 (tock tetris0)
 (make-tetris (drop-block (tetris-block tetris0))
              (tetris-landscape tetris0)))
(check-expect (on-top? tetris1) #false)
(check-expect
 (on-top? (make-tetris
           (make-block (* 0 SIZE) (* 9 SIZE))
           landscape1)) #true)
(check-expect (on-floor? tetris0) #false)
(check-expect
 (on-floor? (make-tetris block1 '())) #true)
(check-expect (drop-block block0)
              (make-block (block-x block0)
                          (+ (block-y block0) SIZE)))
(check-expect
 (control tetris0 "right")
 (make-tetris (make-block (* 1 SIZE) (* 0 SIZE))
              '()))
(check-expect (control tetris0 "left") tetris0)
(check-expect (move-block block0 "left")
              (make-block (- (block-x block0) SIZE)
                     (block-y block0)))
(check-expect (move-block block0 "right")
              (make-block (+ (block-x block0) SIZE)
                     (block-y block0)))
(check-expect (move-block block0 "r") block0)
(check-expect
 (block-on-side?
  (make-tetris
   block0
   (list (make-block (* 1 SIZE) (* 0 SIZE))))
  "right") #true)
(check-expect (on-edge? block0 "left") #true)
(check-expect
 (on-edge? (make-block (* 10 SIZE) (* 0 SIZE))
           "right") #true)