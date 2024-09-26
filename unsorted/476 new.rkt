;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |476 new|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct transition [current key next])
(define-struct fsm [initial transitions final])
 
; An FSM is a structure:
;   (make-fsm FSM-State [List-of 1Transition] FSM-State)
; A 1Transition is a structure:
;   (make-transition FSM-State 1String FSM-State)
; An FSM-State is String.
(define fsm-a-bc*-d
  (make-fsm
   "AA"
   (list (make-transition "AA" "a" "BC")
         (make-transition "BC" "b" "BC")
         (make-transition "BC" "c" "BC")
         (make-transition "BC" "d" "DD"))
   "DD"))
;====================================================;
; FSM String -> Boolean 
; does an-fsm recognize the given string

(check-expect (fsm-match? fsm-a-bc*-d "abb") #true)
(check-expect (fsm-match? fsm-a-bc*-d "acbd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "ad") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abcd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "da") #false)
(check-expect (fsm-match? fsm-a-bc*-d "aa") #false)
(check-expect (fsm-match? fsm-a-bc*-d "d") #false)

(define (fsm-match? an-fsm a-string)
  (local ((define initial-state (fsm-initial an-fsm))
          (define 1s-sequence (explode a-string))
          (define transitions (fsm-transitions an-fsm))  
          ; FSM-state [List-of 1String] -> Boolean
          (define (fsm-match state sequence)
            (cond
              [(empty? sequence) #true]
              [else
               (local ((define maybe-transition
                         (find-transition state transitions (first sequence))))
                 (if (boolean? maybe-transition)
                     #false
                     (fsm-match (transition-next maybe-transition) (rest sequence))))]))
          ; FSM-state [List-of 1Transition] 1String -> [Maybe 1Transition]
          (define (find-transition state transitions key)
            (cond
              [(empty? transitions) #false]
              [else
               (local ((define current (first transitions)))
                 (if (and (equal? state (transition-current current))
                          (equal? key (transition-key current)))
                     current
                     (find-transition state (rest transitions) key)))])))
    (fsm-match initial-state 1s-sequence)))
