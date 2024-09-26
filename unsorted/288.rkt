;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |288|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> [List-of Number]

(check-expect (f0 3) (list 0 1 2))
(check-expect (f1 3) (list 1 2 3))
(check-expect (f2 3) (list 1 1/2 1/3))
(check-expect (f3 6) (list 0 2 4 6 8 10))
(check-expect (f4 3) (list '(1 0 0) '(0 1 0) '(0 0 1)))
(check-expect (tabulate add1 3) (list 4 3 2 1))
(check-expect (tabulate sqr 6) (list 36 25 16 9 4 1 0))

(define (f0 n)
  (build-list n (lambda (x) x)))

(define (f1 n)
  (build-list n (lambda (x) (add1 x))))

(define (f2 n)
  (build-list n (lambda (x) (/ 1 (add1 x)))))

(define (f3 n)
  (build-list n (lambda (x) (+ x x))))

(define (f4 n)
  (build-list n (lambda (x)
                  (build-list n (lambda (z)
                                  (if (= z x) 1 0))))))

(define (tabulate F n)
  (reverse (build-list (add1 n) (lambda (x) (F x)))))