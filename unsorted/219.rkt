;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |219|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; constants
(define L "left")
(define R "right")
(define U "up")
(define D "down")
(define rate 0.2)
(define SIZE 200)
(define RADIUS 3)
(define DIAMETER (* RADIUS 2))
(define WORM (circle RADIUS "solid" "red"))
(define FOOD (circle RADIUS "solid" "green"))
(define SCENE (empty-scene SIZE SIZE "black"))
(define MIN (+ (- SIZE SIZE) (* RADIUS 2)))
(define MAX (- SIZE (* RADIUS 2)))
(define END-TEXT (text "ZHIEND" 12 "white"))
(define TEXT-POSN (/ SIZE 2))
;===================================================;
(define-struct worm [d tail])
; Worm is a structure:
; (make-worm Direction Tail)
; examples:
(define W9
  (make-worm
   R (list (make-posn 50 50) (make-posn 44 50)
           (make-posn 38 50) (make-posn 32 50)
           (make-posn 26 50) (make-posn 20 50)
           (make-posn 14 50) (make-posn 8 50)
           (make-posn 2 50))))

(define-struct game [food worm])
; Game is a structure:
; (make-game Posn Worm)

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
;===================================================;
; Number -> Game
; main function.
(define (worm-main s)
  (big-bang start
    [to-draw render]
    [on-tick tock rate]
    [on-key control]
    [stop-when end? end-scene]))
;===================================================;
; Game -> Image
; render current state of Game
(define (render s)
  (render-game
   (game-food s) FOOD
   (render-tail (worm-tail (game-worm s)))))

; Tail -> Image
; render all item on Tail
(define (render-tail li)
  (cond
    [(empty? (rest li))
     (render-game (first li) WORM SCENE)]
    [else (render-game (first li) WORM
                       (render-tail (rest li)))]))

; Posn Image Image -> Image
; render image on scene with its posn.
(define (render-game pos im sc)
  (place-image im
               (posn-x pos) (posn-y pos)
               sc))
;===================================================;
; Game -> Game
; progress game on clock tick.
(define (tock s)
  (if (not (eat-food? s))
      (make-game (game-food s)
                 (move-worm (game-worm s)))
      (make-game (food-create s)
                 (grow-worm (game-worm s)))))

; Posn -> Posn 
; randomly place food on scene
(define (food-create p)
  (food-check-create
     p (make-posn (random MAX) (random MAX))))
 
; Posn Posn -> Posn 
; generative recursion 
; if p equal to candidate create new p
; else use candidate
(define (food-check-create p candidate)
  (if (equal? p candidate)
      (food-create p) candidate))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

; Game -> boolean
; is worm ate the food?
(define (eat-food? s)
  (if (within (worm-head s) (game-food s))
      #true #false))

; Posn Posn -> Boolean
; is posn a whithin the margin of posn b?
(define (within a b)
  (and (<= (- (posn-x b) 3)
           (posn-x a)
           (+ (posn-x b) 3))
       (<= (- (posn-y b) 3)
           (posn-y a)
           (+ (posn-y b) 3))))

; Game -> Posn
; get the worm head posn.
(define (worm-head w)
  (first (worm-tail (game-worm w))))

; Worm -> Worm
; grow worm by one segment.
(define (grow-worm s)
  (make-worm (worm-d s)
             (add-head (worm-d s) (worm-tail s))))

; Worm -> Worm
; move worm on clock tick.
(define (move-worm s)
  (make-worm (worm-d s)
             (move-tail s)))

; Worm -> Tail
; move tail
(define (move-tail s)
  (last-begone (add-head (worm-d s) (worm-tail s))))

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
;===================================================;
; Game KeyEvents -> Game
; create new game state on keyevents
(define (control s ke)
  (make-game (game-food s)
             (operate-worm (game-worm s) ke)))

; Worm KeyEvents -> Worm
; control worm moving direction.
(define (operate-worm s ke)
  (cond [(member? ke DIRECTIONS)
         (if (= 1 (length (worm-tail s)))
             (make-worm ke (worm-tail s))
             (if (equal?
                  (head ke (first (worm-tail s)))
                  (second (worm-tail s)))
                 s (make-worm ke (worm-tail s))))]
        [else s]))
;===================================================;
; Game -> Boolean
; is game end?
(define (end? s)
  (hit-wall/body? (game-worm s)))

; Worm -> Boolean
; is head hit wall/body?
(define (hit-wall/body? s)
  (or (hit-wall? (first (worm-tail s)))
      (hit-body? (worm-tail s))))

; Posn -> Boolean
; is head hit wall?
(define (hit-wall? pos)
  (or (< (posn-x pos) (- MIN 6))
          (> (posn-x pos) (+ MAX 6)) 
          (< (posn-y pos) (- MIN 6))
          (> (posn-y pos) (+ MAX 6))))

; Tail -> Boolean
; is head hit body?
(define (hit-body? s)
  (member? (first s) (rest s)))

; Worm -> Image
; render ending scene.
(define (end-scene s)
  (place-image END-TEXT
               TEXT-POSN TEXT-POSN
               (render s)))
;===================================================;
; tests
;(check-expect
; (render start)
; (render-game fod FOOD
;   (render-tail head-tail)))
;(check-expect (worm-head start) head-posn)
;(check-expect (eat-food? start) #false)
;(check-expect (eat-food?
;  (make-game (make-posn 10 10)
;            (make-worm R (list (make-posn 10 10)))))
;              #true)
;(check-expect (eat-food?
;  (make-game (make-posn 10 10)
;             (make-worm R (list (make-posn 10 6)))))
;              #false)
;(check-expect (last-begone (list 1)) '())
;(check-expect (last-begone (list 1 2)) (list 1))
;(check-expect (add-head L (list (make-posn 50 50)))
;              (list (make-posn 44 50)
;                    (make-posn 50 50)))
;(check-expect (add-head R (list (make-posn 50 50)))
;              (list (make-posn 56 50)
;                    (make-posn 50 50)))
;(check-expect (add-head U (list (make-posn 50 50)))
;              (list (make-posn 50 44)
;                    (make-posn 50 50)))
;(check-expect (add-head D (list (make-posn 50 50)))
;              (list (make-posn 50 56)
;                    (make-posn 50 50)))
;(check-expect (head L (make-posn 50 50))
;              (make-posn 44 50))
;(check-expect (head R (make-posn 50 50))
;              (make-posn 56 50))
;(check-expect (head U (make-posn 50 50))
;              (make-posn 50 44))
;(check-expect (head D (make-posn 50 50))
;              (make-posn 50 56))
;(check-expect (move-tail woorm)
;              (list (make-posn 56 100)
;                    (make-posn 50 100)))
;(check-expect
; (move-worm woorm)
; (make-worm R (list (make-posn 56 100)
;                    (make-posn 50 100))))
;(check-expect
; (grow-worm woorm)
; (make-worm R (list (make-posn 56 100)
;                    (make-posn 50 100)
;                    (make-posn 44 100))))
;(check-satisfied
; (food-create (make-posn 1 1)) not=-1-1?)
;(check-expect (hit-wall? (make-posn -1 50)) #true)
;(check-expect (hit-wall? (make-posn (+ MAX 1) 50))
;              #true)
;(check-expect (hit-wall? (make-posn 50 -1)) #true)
;(check-expect (hit-wall? (make-posn 50 (+ MAX 1)))
;              #true)
;(check-expect (hit-wall? (make-posn 10 50)) #false)
;(check-expect (hit-body? (list (make-posn 50 50)
;                               (make-posn 56 50)))
;                         #false)
;(check-expect (hit-body? (list (make-posn 50 50)
;                               (make-posn 50 50)))
;                         #true)
;(check-expect (hit-wall/body?
;               (make-worm "left"
;                          (list (make-posn 0 50))))
;              #true)
;(check-expect (hit-wall/body?
;               (make-worm "left"
;                          (list (make-posn 10 50))))
;              #false)
;(check-expect
; (end-scene (make-worm "right"
;                       (list (make-posn 50 50))))
; (place-image END-TEXT TEXT-POSN TEXT-POSN
;              (place-image WORM 50 50 SCENE)))
;===================================================;
(define fod (food-create (make-posn 1 1)))
(define head-posn (make-posn (/ SIZE 4) (/ SIZE 2)))
(define tail-posn (make-posn 44 100))
(define head-tail (list head-posn))
(define woorm (make-worm R head-tail))
(define start (make-game fod woorm))

; Any -> Number
(define (run x)
  (length (worm-tail (game-worm (worm-main rate)))))

(run 0)