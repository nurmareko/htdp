;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |229|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; An FSM is one of:
;   – '()
;   – (cons Transition FSM)
 
(define-struct ktransition [current key next])
; A Transition.v2 is a structure:
;   (make-ktransition FSM-State KeyEvent FSM-State)
 
; FSM-State is a String.
 
; interpretation An FSM represents the transitions
; that a finite state machine can take from one state
; to another in reaction to keystrokes

(define-struct fs [fsm current])
; A SimulationState.v2 is a structure: 
;   (make-fs FSM FSM-State)

(define AA "start, ...")
(define BB "expect ...")

(define fsm-109
  (list (make-ktransition AA "a" BB)
        (make-ktransition BB "b" BB)
        (make-ktransition BB "c" BB)))
;====================================================;
; FSM-State FSM-State -> Boolean
; equality predicate for states.

(check-expect (state=? "green" "green") #true)

(define (state=? a b)
  (string=? a b))

; FSM FSM-State -> SimulationState.v2 
; match the keys pressed with the given FSM 
(define (simulate.v2 an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw state-as-text]
    [on-key find-next-state]))
;====================================================;
; SimulationState.v2 -> Image 
; renders current world state as a colored square 
 
(check-expect (state-as-text (make-fs fsm-109 AA))
              (text AA 36 "indigo"))
 
(define (state-as-text an-fsm)
  (text (fs-current an-fsm) 36 "indigo"))
;====================================================; 
; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from an-fsm and ke

(check-expect
 (find-next-state (make-fs fsm-109 AA) "a")
 (make-fs fsm-109 BB))
(check-expect
 (find-next-state (make-fs fsm-109 BB) "b")
 (make-fs fsm-109 BB))
(check-expect
 (find-next-state (make-fs fsm-109 BB) "c")
 (make-fs fsm-109 BB))
(check-error
 (find-next-state (make-fs fsm-109 AA) "b")
 "error: wrong key sequence.")
(check-error
 (find-next-state (make-fs fsm-109 BB) "a")
 "error: wrong key sequence.")

(define (find-next-state an-fsm ke)
  (make-fs
    (fs-fsm an-fsm)
    (find (fs-fsm an-fsm) (fs-current an-fsm) ke)))

; FSM FSM-State KeyEvent -> FSM-State
; finds the state representing current in transitions
; and retrieves the next field 
(define (find transitions current key)
  (cond
    [(empty? transitions)
     (error "error: wrong key sequence.")]
    [else (if (and (current=? current (first transitions))
                   (fskey=? key (first transitions)))
              (ktransition-next (first transitions))
              (find (rest transitions) current key))]))

; FSM-State Transition.v2 -> Boolean
; is FSM-State equal to Transition.v2 current?

(check-expect
 (current=? AA (make-ktransition AA "a" BB)) #true)
(check-expect
 (current=? BB (make-ktransition AA "a" BB)) #false)

(define (current=? a b)
  (state=? a (ktransition-current b)))

; KeyEvent Transition.v2 -> Boolean
; is KeyEvent equal to Transition.v2 key?

(check-expect
 (fskey=? "a" (make-ktransition AA "a" BB)) #true)
(check-expect
 (fskey=? "b" (make-ktransition AA "a" BB)) #false)

(define (fskey=? a b)
  (string=? a (ktransition-key b)))


;====================================================;