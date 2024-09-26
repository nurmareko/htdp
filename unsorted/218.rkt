;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |218|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; constants
(define L "left")
(define R "right")
(define U "up")
(define D "down")
(define TICK-RATE 0.1)
(define SIZE 200)
(define RADIUS 3)
(define DIAMETER (* RADIUS 2))
(define START-POSN (make-posn (/ SIZE 4) (/ SIZE 2)))
(define HEAD (list START-POSN))
(define WORM (circle RADIUS "solid" "red"))
(define SCENE (empty-scene SIZE SIZE "black"))
(define MIN (+ (- SIZE SIZE) (* RADIUS 2)))
(define MAX (- SIZE (* RADIUS 2)))
(define END-TEXT (text "ZHIEND" 12 "white"))
(define TEXT-POSN (/ SIZE 2))

(define-struct worm [ d tail])
; Worm is a structure:
; (make-worm Direction Tail)
; examples:
(define START
  (make-worm R HEAD))
(define W9
  (make-worm
   R (list (make-posn 50 50) (make-posn 44 50)
           (make-posn 38 50) (make-posn 32 50)
           (make-posn 26 50) (make-posn 20 50)
           (make-posn 14 50) (make-posn 8 50)
           (make-posn 2 50))))

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

; Number -> Worm
; main function.
(define (worm-main s)
  (big-bang W9
    [to-draw render]
    [on-tick move TICK-RATE]
    [on-key director]
    [stop-when hit-wall/body? end-scene]
    [state #true]))

; Worm -> Image
;render current state of Worm
(define (render s)
  (render-tail (worm-tail s)))

; Tail -> Image
; render all item on Tail
(define (render-tail li)
  (cond
    [(empty? (rest li))
     (render-posn (first li) SCENE)]
    [else (render-posn (first li)
                       (render-tail (rest li)))]))

; Posn Image -> Image
; render posn on the given image
(define (render-posn pos im)
  (place-image WORM
               (posn-x pos) (posn-y pos)
               im))

; Worm -> Worm
; move worm on clock tick.
(define (move s)
  (make-worm (worm-d s)
             (last-begone (add-head (worm-d s)
                                    (worm-tail s)))))

; Tail -> Tail
; remove last item on a list.
(define (last-begone li)
  (cond
    [(empty? (rest li)) '()]
    [else (cons (first li)
                (last-begone (rest li)))]))

; Direction Tail -> Tail
; add new head to a Tail.
(define (add-head d li)
  (cons (head d (first li)) li))

; Direction Posn -> Posn
; produce new posn base on direction.
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

; Worm KeyEvents -> Worm
; control worm moving direction.
(define (director s ke)
  (cond [(member? ke DIRECTIONS)
         (if (= 1 (length (worm-tail s)))
             (make-worm ke (worm-tail s))
             (if (equal?
                  (head ke (first (worm-tail s)))
                  (second (worm-tail s)))
                 s (make-worm ke (worm-tail s))))]
        [else s]))

; Posn -> Boolean
; is head hit wall?
(define (hit-wall? pos)
  (if (or (< (posn-x pos) MIN)
          (> (posn-x pos) MAX)
          (< (posn-y pos) MIN)
          (> (posn-y pos) MAX))
  #true #false))

; Tail -> Boolean
; is head hit body?
(define (hit-body? s)
  (if (member? (first s) (rest s))
     #true #false))

; Worm -> Boolean
; is head hit wall/body?
(define (hit-wall/body? s)
  (if (or (hit-wall? (first (worm-tail s)))
          (hit-body? (worm-tail s)))
      #true #false))

; Worm -> Image
; render ending scene.
(define (end-scene s)
  (place-image END-TEXT
               TEXT-POSN TEXT-POSN
               (render s)))

; tests
(check-expect
 (render (make-worm "right"
                    (list (make-posn 50 50)
                          (make-posn 44 50))))
 (place-image WORM 44 50
              (place-image WORM 50 50 SCENE)))
(check-expect
 (move (make-worm "left" (list (make-posn 50 50))))
 (make-worm "left" (list (make-posn 44 50))))
(check-expect (last-begone (list 1)) '())
(check-expect (last-begone (list 1 2)) (list 1))
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
(check-expect (head L (make-posn 50 50))
              (make-posn 44 50))
(check-expect (head R (make-posn 50 50))
              (make-posn 56 50))
(check-expect (head U (make-posn 50 50))
              (make-posn 50 44))
(check-expect (head D (make-posn 50 50))
              (make-posn 50 56))
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
(check-expect
 (director (make-worm L (list (make-posn 50 50)
                              (make-posn 56 50)))
           "right")
 (make-worm L (list (make-posn 50 50)
                    (make-posn 56 50))))
(check-expect
 (director (make-worm L (list (make-posn 50 50)
                              (make-posn 56 50)))
           "up")
 (make-worm U (list (make-posn 50 50)
                    (make-posn 56 50))))
(check-expect (hit-wall? (make-posn -1 50)) #true)
(check-expect (hit-wall? (make-posn (+ MAX 1) 50))
              #true)
(check-expect (hit-wall? (make-posn 50 -1)) #true)
(check-expect (hit-wall? (make-posn 50 (+ MAX 1)))
              #true)
(check-expect (hit-wall? (make-posn 10 50)) #false)
(check-expect (hit-body? (list (make-posn 50 50)
                               (make-posn 56 50)))
                         #false)
(check-expect (hit-body? (list (make-posn 50 50)
                               (make-posn 50 50)))
                         #true)
(check-expect (hit-wall/body?
               (make-worm "left"
                          (list (make-posn 0 50))))
              #true)
(check-expect (hit-wall/body?
               (make-worm "left"
                          (list (make-posn 10 50))))
              #false)
(check-expect
 (end-scene (make-worm "right"
                       (list (make-posn 50 50))))
 (place-image END-TEXT TEXT-POSN TEXT-POSN
              (place-image WORM 50 50 SCENE)))