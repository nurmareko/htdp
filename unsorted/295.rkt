;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |295|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)
 
; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))
(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))))

; Number -> [[List-of Posn] -> Boolean]
; a specification of the random-posns function

(check-expect [(n-inside-playground? 0) '()] #true)
(check-expect [(n-inside-playground? 0) (list (make-posn 5 5))] #false)
(check-expect [(n-inside-playground? 0) (make-posn 5 5)] #false)
(check-expect [(n-inside-playground? 1) (list (make-posn 5 5))] #true)
(check-expect [(n-inside-playground? 2) (list 50 50)] #false)
(check-expect [(n-inside-playground? 1) "a"] #false)
(check-expect [(n-inside-playground? 1) (make-posn 5 5)] #false)
(check-expect [(n-inside-playground? 1) (list (make-posn 300 5))] #false)
(check-expect [(n-inside-playground? 1) (list (make-posn 5 301))] #false)

(define (n-inside-playground? n)
  (lambda (rs)
    (if (zero? n) (empty? rs)
        (and (list? rs)
             (= n (length rs))
             (andmap (lambda (p)
                       (and (posn? p)
                            (< (posn-x p) WIDTH)
                            (< (posn-y p) HEIGHT)))
                     rs)))))

; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns/bad 3)
                 (n-inside-playground? 3))
(define (random-posns/bad n)
  (build-list n (lambda (i)
                  (make-posn 0 0))))