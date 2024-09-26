;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |523 create-next-states|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct mc [left right river path])
; PuzzleState is a structure:
;  (make-puzzle [Pair N N]
;               [Pair N N]
;               [or "left" "right"]
;               [List-of PuzzleState])
; interpretation
; (1) (list N N) represent the number of missionary and cannibal on a bank
;     - the first N represent the number of missionary
;     - the second N represent the number of cannibal
; (2) (or "left" "right") represent the location of a boat on a river
;     - "left" represent a boat on the left side of the river
;     - "right" represent a boat on the right side of the river
; (3) accumulator path is the sequence of PuzzleState to get
;     to the current state.

; stage-0
(define stage-0 (make-mc '(3 3) "left" '(0 0) '()))
; 5 alternatives of the next state from stage 0
(define stage-1-1 (make-mc '(3 2) "right" '(0 1) '(stage-0)))
(define stage-1-2 (make-mc '(3 1) "right" '(0 2) '(stage-0)))
(define stage-1-3 (make-mc '(2 2) "right" '(1 1) '(stage-0)))
(define stage-1-4 (make-mc '(1 3) "right" '(2 0) '(stage-0))) ; bad
(define stage-1-5 (make-mc '(2 3) "right" '(1 0) '(stage-0))) ; bad
; 5 alternatives of the next state from stage 1 option 1
(define stage-2-1 (make-mc '(3 1) "left" '(0 2) '(stage-1-1 stage-0)))
(define stage-2-2 (make-mc '(3 0) "left" '(0 3) '(stage-1-1 stage-0)))
(define stage-2-3 (make-mc '(2 1) "left" '(1 2) '(stage-1-1 stage-0))) ; bad
(define stage-2-4 (make-mc '(1 2) "left" '(2 1) '(stage-1-1 stage-0))) ; bad
(define stage-2-5 (make-mc '(2 2) "left" '(1 1) '(stage-1-1 stage-0)))
; 5 alternatives of the next state from stage 1 option 2
(define stage-2-6  (make-mc '(3 0)  "left" '(0 3) '(stage-1-2 stage-0)))
(define stage-2-7  (make-mc '(3 -1) "left" '(0 4) '(stage-1-2 stage-0))) ; bad
(define stage-2-8  (make-mc '(2 0)  "left" '(1 3) '(stage-1-2 stage-0))) ; bad
(define stage-2-9  (make-mc '(1 1)  "left" '(2 2) '(stage-1-2 stage-0)))
(define stage-2-10 (make-mc '(2 1)  "left" '(1 2) '(stage-1-2 stage-0))) ; bad
; 5 alternatives of the next state from stage 1 option 3
(define stage-2-11 (make-mc '(2 1) "left" '(1 2) '(stage-1-3 stage-0))) ; bad
(define stage-2-12 (make-mc '(2 0) "left" '(1 3) '(stage-1-3 stage-0))) ; bad
(define stage-2-13 (make-mc '(1 1) "left" '(2 2) '(stage-1-3 stage-0)))
(define stage-2-14 (make-mc '(0 2) "left" '(3 1) '(stage-1-3 stage-0)))
(define stage-2-15 (make-mc '(1 2) "left" '(2 1) '(stage-1-3 stage-0))) ; bad
;=========================================================================;
; [List-of PuzzleState] -> [List-of PuzzleState]
; generates the list of all those states that a boat ride can reach.
(define (create-next-states states) '())