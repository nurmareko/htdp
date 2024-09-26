;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |294|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [X] X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise

(check-satisfied (index 1 '()) (is-index? 1 '()))
(check-satisfied (index 1 '(0)) (is-index? 1 '(0)))
(check-satisfied (index 1 '(0 1)) (is-index? 1 '(0 1)))
(check-satisfied (index 1 '(0 0 1 0 0 1)) (is-index? 1 '(0 0 1 0 0 1)))

(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))
;====================================================;
; [X] X [List-of X] -> [[Maybe N] -> Boolean]
; specification of a index function
; confirm that result is the correct answer
; result must be #false or a Number

; if result is #false confirm that lx is empty list,
; or x is not appear in lx
(check-expect [(is-index? 0 '()) #false] #true)
(check-expect [(is-index? 0 '(1)) #false] #true)
(check-expect [(is-index? 0 '()) 0] #false)
(check-expect [(is-index? 0 '(0)) #false] #false)
(check-expect [(is-index? 0 '()) '()] #false)
; if result is other than #false confirm that result
; is a Number, (add1 result) is less than or equal to
; lx length, and result is the index of first
; occurrence of x in lx
(check-expect [(is-index? 0 '(0)) 0] #true)
(check-expect [(is-index? 0 '(0 1)) 0] #true)
(check-expect [(is-index? 0 '(1 0)) 1] #true)
(check-expect [(is-index? 0 '(1 0 1 0)) 1] #true)
(check-expect [(is-index? 0 '(0)) 1] #false)
(check-expect [(is-index? 0 '(1 1 1 0)) 4] #false)
(check-expect [(is-index? 0 '(1 0 1 0)) 3] #false)

(define (is-index? x lx)
  (lambda (result)
    (cond
      [(false? result)
       (or (empty? lx) (not (member? x lx)))]
      [(number? result)
       (and (not (empty? lx))
            (<= result (length lx))
            (= result (1st-x-index x lx)))]
      [else #false])))
;====================================================;
; [X] X [NEList-of X] -> Number
; find the index of the first occurrence of x in lx

(check-expect (1st-x-index 0 '(0)) 0)
(check-expect (1st-x-index 0 '(0 0)) 0)
(check-expect (1st-x-index 0 '(0 1)) 0)
(check-expect (1st-x-index 0 '(1 0 1 0)) 1)

(define (1st-x-index x lx)
 (- (length lx) (length (memv x lx))))