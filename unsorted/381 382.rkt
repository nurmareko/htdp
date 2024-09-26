;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |381 382|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An XMachine is a nested list of this shape:
;   (cons 'machine (cons (cons (cons 'initial (cons FSM-State '())) '())  [List-of X1T]))
; An X1T is a nested list of this shape:
;   (cons 'action (cons (cons 'state (cons FSM-State '())) (cons 'next (cons FSM-State '()))))

; An FSM is a [List-of 1Transition]
; A 1Transition is a list of two items:
;   (cons FSM-State (cons FSM-State '()))
; An FSM-State is a String that specifies a color
 
; data examples 
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))

(define xm0
  '(machine ((initial "red"))
     (action ((state "red") (next "green")))
     (action ((state "green") (next "yellow")))
     (action ((state "yellow") (next "red")))))

;<machine initial="black">
;  <action state="black"    next="white" />
;  <action state="white"  next="black" />
;</machine>
;
;(define xm0
;  '(machine ((initial "black"))
;     (action ((state "black") (next "white")))
;     (action ((state "white") (next "black")))))
;====================================================;
; XMachine -> FSM-State
; simulates an FSM via the given configuration 
(define (simulate-xmachine xm)
  (simulate (xm-state0 xm) (xm->transitions xm)))

; XMachine -> FSM-State 
; extracts and translates the transition table from xm0
 
(check-expect (xm-state0 xm0) "red")
 
(define (xm-state0 xm0)
  (find-attr (xexpr-attr xm0) 'initial))

; XMachine -> [List-of 1Transition]
; extracts the transition table from xm
 
(check-expect (xm->transitions xm0) fsm-traffic)
 
(define (xm->transitions xm)
  (local (; X1T -> 1Transition
          (define (xaction->action xa)
            (list (find-attr (xexpr-attr xa) 'state)
                  (find-attr (xexpr-attr xa) 'next))))
    (map xaction->action (xexpr-content xm))))
;====================================================;
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
        (find transitions current))]))
 
; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))
;====================================================;
; [List-of Attribute] Symbol -> [or String #false]
; If the attributes list associates the symbol with a
; string, the function retrieves this string
; otherwise it returns #false.
(define (find-attr al sym)
  (local ((define attr (assq sym al)))
    (if (list? attr) (second attr) attr)))

; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the list of Xexpr.v2 of xe
(define (xexpr-content xe)
  (local ((define body (rest xe)))
    (cond
      [(empty? body) body]
      [else
       (if (not (list-of-attributes? (first body)))
           body
           (rest body))])))

; AttrsOrXexpr -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))
