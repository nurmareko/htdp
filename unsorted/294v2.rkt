;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 294v2) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
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
(check-expect [(is-index? 0 '(0)) '()] #false)
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
  (lambda (rs)
    (if (empty? lx) (false? rs)
        (cond [(false? rs)
               (not (member? x lx))]
              [(number? rs)
               (and (<= rs (length lx))
                    (equal? (memv-indx rs lx) (memv x lx)))]
              [else #false]))))
;====================================================;
; Number [List-of X] -> [Maybe [NEList-of X]]
; produces the suffix of the list that starts with
; item at index n if not, it produces false. 

(check-expect (memv-indx 1 '()) #false)
(check-expect (memv-indx 10 '(1 2 3)) #false)
(check-expect (memv-indx 1 (list 1 0 1 0)) (list 0 1 0))

(define (memv-indx n lx)
  (cond
    [(or (empty? lx) (> (add1 n) (length lx))) #false]
    [(zero? n) lx]
    [else (memv-indx (sub1 n) (rest lx))]))