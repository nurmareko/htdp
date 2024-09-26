;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |476|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct transition [current key next])
(define-struct fsm [initial transitions final])
 
; An FSM is a structure:
;   (make-fsm FSM-State [List-of 1Transition] FSM-State)
; A 1Transition is a structure:
;   (make-transition FSM-State 1String FSM-State)
; An FSM-State is String.
 
; data example: see exercise 109
 
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

;(check-expect (fsm-match? fsm-a-bc*-d "acbd") #true)
;(check-expect (fsm-match? fsm-a-bc*-d "ad") #true)
;(check-expect (fsm-match? fsm-a-bc*-d "abcd") #true)
;(check-expect (fsm-match? fsm-a-bc*-d "da") #false)
;(check-expect (fsm-match? fsm-a-bc*-d "aa") #false)
;(check-expect (fsm-match? fsm-a-bc*-d "d") #false)

(define (fsm-match? an-fsm a-string)
  (local ((define current-state ...)
          (define current-sequence ...) 
  #false)
;====================================================;
; FSM [List-of 1String] -> Boolean
; does an-fsm recognize the given list of 1String

(check-expect (fsm-math?/list fsm-a-bc*-d '()) #true)
;(check-expect (fsm-math?/list fsm-a-bc*-d (explode "acbd")) #true)
;(check-expect (fsm-math?/list fsm-a-bc*-d (explode "ad")) #true)
;(check-expect (fsm-math?/list fsm-a-bc*-d (explode "abcd")) #true)
;(check-expect (fsm-math?/list fsm-a-bc*-d (explode "da")) #false)
;(check-expect (fsm-math?/list fsm-a-bc*-d (explode "aa")) #false)
;(check-expect (fsm-math?/list fsm-a-bc*-d (explode "d")) #false)

(define (fsm-math?/list an-fsm l)
  (cond
    [(empty? l) #true]
    [else
     (... (first l) ...
      ... (fsm-math?/list an-fsm (rest l)) ...)]))
     
















