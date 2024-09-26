;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |380|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An FSM is a [List-of 1Transition]
; A 1Transition is a list of three items:
;   (list FSM-State FSM-State KeyEvent)
; An FSM-State is a String that specifies a color
 
; data examples 
(define fsm-traffic
  '(("red" "green" "a") ("green" "yellow" "s") ("yellow" "red" "d")))

; FSM-State FSM -> FSM-State 
; matches the keys pressed by a player with the given FSM 
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw
     (lambda (current)
       (overlay
        (text current 20 "black")
        (square 100 "solid" current)))]
    [on-key
     (lambda (current key-event)
       (local ((define transition-key
                 (third (assoc current transitions))))
         (if (equal? key-event transition-key)
             (find transitions current)
             current)))]))
 
; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist

(check-expect (find (list (list 1 2)) 1) 2)
(check-expect (find (list (list 1 2) (list 2 3)) 2) 3)
(check-error (find '() 1))
(check-error (find (list (list 1 2)) 2))

(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))