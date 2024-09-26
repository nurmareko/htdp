;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |230|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define-struct fsm [initial transitions final])
(define-struct transition [current key next])

; An FSM.v2 is a structure: 
;   (make-fsm FSM-State LOT FSM-State)

; A LOT is one of: 
; – '() 
; – (cons Transition.v3 LOT)

; A Transition.v3 is a structure: 
;   (make-transition FSM-State KeyEvent FSM-State)

; FSM-State is one of String:
; - AA
; - BB
; - DD
(define AA "start, ...")
(define BB "expect ...")
(define DD "finished")
(define ER "error, ...")

(define transitions-109
  (list (make-transition AA "a" BB)
        (make-transition BB "b" BB)
        (make-transition BB "c" BB)
        (make-transition BB "d" DD)))

(define fsm-109
  (make-fsm AA transitions-109 DD))
;====================================================;
; FSM.v2 -> FSM.v2
; match the keys pressed with the given FSM
(define (fsm-main s)
  (big-bang s
    [to-draw state-as-text]
    [on-key find-next-state]
   [stop-when final-state?]))
;====================================================;
; FSM.v2 -> Image
; renders current world state as a text image
(define (state-as-text s)
  (text (fsm-initial s) 20 "indigo"))
;====================================================; 
; FSM.v2 -> FSM.v2
; finds the next state from s and ke
(define (find-next-state s ke)
  (make-fsm (find (fsm-initial s) (fsm-transitions s) ke)
            (fsm-transitions s)
            (fsm-final s)))

; FSM-State LOT KeyEvent -> FSM-State
; finds the state representing current in transitions
; and retrieves the next field
(define (find in tr ke)
  (cond
    [(empty? tr) (error ER)]
    [else (if (and (string=? in (transition-current (first tr)))
                   (key=? ke (transition-key (first tr))))
              (transition-next (first tr))
              (find in (rest tr) ke))]))
;====================================================;
; FSM.v2 -> Boolean
; is s represent final state?
(define (final-state? s)
  (string=? (fsm-initial s) (fsm-final s)))
;====================================================;
; tests
(check-expect (state-as-text fsm-109)
              (text AA 20 "indigo"))
(check-expect (final-state? fsm-109)
              #false)
(check-expect
 (final-state? (make-fsm DD transitions-109 DD))#true)
(check-expect (find-next-state fsm-109 "a")
              (make-fsm BB transitions-109 DD))
(check-expect
 (find-next-state (make-fsm BB transitions-109 DD) "b")
 (make-fsm BB transitions-109 DD))
(check-expect
 (find-next-state (make-fsm BB transitions-109 DD) "c")
 (make-fsm BB transitions-109 DD))
(check-expect
 (find-next-state (make-fsm BB transitions-109 DD) "d")
 (make-fsm DD transitions-109 DD))
(check-error (find-next-state fsm-109 "b") ER)
(check-error
 (find-next-state (make-fsm BB transitions-109 DD) "a")
 ER)
(check-expect (find AA transitions-109 "a") BB)
(check-expect (find BB transitions-109 "b") BB)
(check-expect (find BB transitions-109 "c") BB)
(check-expect (find BB transitions-109 "d") DD)
(check-error (find AA transitions-109 "b") ER)
(check-error (find BB transitions-109 "a") ER)