;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |217 on-tick wishlist|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define DIAMETER 6)
(define L "left")
(define R "right")
(define U "up")
(define D "down")

(define-struct worm [ d tail])
; Worm is:
; (make-worm Direction Tail)

; Direction is one of: 
; – L
; – R 
; – U
; - D
; or, equivalently, a member? of this list: 
(define DIRECTIONS
  (list L R U D))

; Tail is one of:
; - (list Posn)
; - (cons Posn Tail)

; Tail -> Tail
; remove last item on a list.
(check-expect (last-begone (list 1)) '())
(check-expect (last-begone (list 1 2)) (list 1))                           

(define (last-begone li)
  (cond
    [(empty? (rest li)) '()]
    [else (cons (first li)
                (last-begone (rest li)))]))

; Direction Tail -> Tail
; add new head to a Tail.
(check-expect (add-head L (list (make-posn 50 50)))
              (list (make-posn 44 50)
                    (make-posn 50 50)))
(check-expect (add-head R (list (make-posn 50 50)))
              (list (make-posn 56 50)
                    (make-posn 50 50)))
(check-expect (add-head U (list (make-posn 50 50)))
              (list (make-posn 50 44)
                    (make-posn 50 50)))
(check-expect (add-head D (list (make-posn 50 50)))
              (list (make-posn 50 56)
                    (make-posn 50 50)))

(define (add-head d li)
  (cons (head d (first li)) li))

; Direction Posn -> Posn
; produce new posn base on direction.
(check-expect (head L (make-posn 50 50))
              (make-posn 44 50))
(check-expect (head R (make-posn 50 50))
              (make-posn 56 50))
(check-expect (head U (make-posn 50 50))
              (make-posn 50 44))
(check-expect (head D (make-posn 50 50))
              (make-posn 50 56))

(define (head d pos)
  (cond [(string=? L d)
         (make-posn (- (posn-x pos) DIAMETER)
                    (posn-y pos))]
        [(string=? R d)
         (make-posn (+ (posn-x pos) DIAMETER)
                    (posn-y pos))]
        [(string=? U d)
         (make-posn (posn-x pos)
                    (- (posn-y pos) DIAMETER))]
        [(string=? D d)
         (make-posn (posn-x pos)
                    (+ (posn-y pos) DIAMETER))]))

; Worm -> Worm
; move worm on clock tick.
(check-expect
 (move (make-worm "left" (list (make-posn 50 50))))
 (make-worm "left" (list (make-posn 44 50))))

(define (move s)
  (make-worm (worm-d s)
             (last-begone (add-head (worm-d s)
                                    (worm-tail s)))))