;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |480|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define SCALE 40)
(define QUEEN-SIZE (* 0.5 SCALE))
(define OFFSET QUEEN-SIZE)
(define QUEEN (circle QUEEN-SIZE "solid" "red"))
(define CELL (square SCALE "outline" "black"))
(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at
; the r-th row and c-th column

;====================================================;
; N [List-of QP] Image -> Image
; produces an image of an n by n chess board with the
; given image placed according to the given QPs.

(check-expect (render-queens 3 (list (make-posn 0 0)) QUEEN)
              (place-image QUEEN
                           (+ (* 0 SCALE) OFFSET) (+ (* 0 SCALE) OFFSET)
                           (make-board 3 CELL)))
(check-expect (render-queens 3 (list (make-posn 1 1)) QUEEN)
              (place-image QUEEN
                           (+ (* 1 SCALE) OFFSET) (+ (* 1 SCALE) OFFSET)
                           (make-board 3 CELL)))
(check-expect (render-queens 3 (list (make-posn 2 2)) QUEEN)
              (place-image QUEEN
                           (+ (* 2 SCALE) OFFSET) (+ (* 2 SCALE) OFFSET)
                           (make-board 3 CELL)))
(check-expect (render-queens 3 (list (make-posn 0 0) (make-posn 2 1)) QUEEN)
              (place-image QUEEN
                           (+ (* 2 SCALE) OFFSET) (+ (* 1 SCALE) OFFSET)
                           (place-image QUEEN
                                        (+ (* 0 SCALE) OFFSET) (+ (* 0 SCALE) OFFSET)
                                        (make-board 3 CELL))))

(define (render-queens n queens img)
  (local ((define board (make-board n CELL))
          (define adapted-queens (adapt queens)))
    (foldr (lambda (queen re)
             (place-image img
                          (posn-x queen) (posn-y queen)
                          re))
           board
           adapted-queens)))

; N Image -> Image
; make (* n n) grid.
(define (make-board n img)
  (local (; [Image -> Image] N Image -> Image
          (define (arrange f n img)
            (cond
              {(zero? n) empty-image}
              [else
               (f img (arrange f (sub1 n) img))])))
    (arrange beside n (arrange above n img))))

; Number -> NUmber
; adapt a list of posn to SCALE and OFFSET.
(define (adapt posns)
  (map (lambda (q)
         (make-posn (+ (* (posn-x q) SCALE) OFFSET)
                    (+ (* (posn-y q) SCALE) OFFSET)))
       posns))
