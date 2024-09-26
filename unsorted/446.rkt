;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |446|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define ε 0.001)

; check within ε find-root helper
(define (within? n)
  (<= (abs (poly n)) ε))

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption

(check-satisfied (find-root poly 3 6) within?)

(define (find-root f left right)
  (cond
    [(<= (- right left) ε) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid))
              (define f@left (f left))
              (define f@right (f right)))
        (cond
          [(or (<= f@left 0 f@mid) (<= f@mid 0 f@left))
           (find-root f left mid)]
          [(or (<= f@mid 0 f@right) (<= f@right 0 f@mid))
           (find-root f mid right)]))]))
;====================================================;
; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))
