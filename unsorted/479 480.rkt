;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |479 480|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define QUEEN
  (circle 5 "solid" "darkmagenta"))
(define CELL
  (square 10 "outline" "darkblue"))

(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at 
; the r-th row and c-th column
;====================================================;
; QP QP -> Boolean
; are queen a and b threaten each other?

(check-expect (threatening? (make-posn 3 4) (make-posn 3 7)) #true)
(check-expect (threatening? (make-posn 3 4) (make-posn 0 4)) #true)
(check-expect (threatening? (make-posn 3 4) (make-posn 5 6)) #true)
(check-expect (threatening? (make-posn 3 4) (make-posn 7 0)) #true)
(check-expect (threatening? (make-posn 3 4) (make-posn 4 6)) #false)
(check-expect (threatening? (make-posn 3 4) (make-posn 2 2)) #false)

(define (threatening? a b)
  (or (= (posn-x a) (posn-x b))
      (= (posn-y a) (posn-y b))
      (= (+ (posn-x a) (posn-y a))
         (+ (posn-x b) (posn-y b)))
      (= (abs (- (posn-x a) (posn-y a)))
         (abs (- (posn-x b) (posn-y b))))))
;====================================================;
; N [List-of QP] Image -> Image
; produces an image of an n by n chess board with the
; given image placed according to the given QPs.
(define (render-queens n lqp img)
  (local (; [Image -> Image]
          (define (render-board f n img)
            (cond
              [(zero? n) empty-image]
              [else
               (f img (render-board f (sub1 n) img))]))
          
          (define chess-board
            (render-board beside n(render-board above n CELL)))
          
          ; [List-of QP] Image -> Image
          (define (place-queens lq img)
            (local (; Number -> Number
                    (define (scale n) (+ (* n 10) 5)))
              (cond
                [(empty? lq) chess-board]
                [else
                 (place-image img
                              (scale (posn-x (first lq)))
                              (scale (posn-y (first lq)))
                              (place-queens (rest lq) img))]))))
    (place-queens lqp img)))











   