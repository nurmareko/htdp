;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |250|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list

(check-expect (tab-sin 0) (list (sin 0)))
(check-within (tab-sin 2)
              (list (sin 2) (sin 1) (sin 0)) 0.01)

(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else
     (cons
      (sin n)
      (tab-sin (sub1 n)))]))

; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list

(check-expect (tab-sqrt 0) (list (sqrt 0)))
(check-within (tab-sqrt 2)
              (list (sqrt 2) (sqrt 1) (sqrt 0)) 0.01)

(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons
      (sqrt n)
      (tab-sqrt (sub1 n)))]))
;====================================================;
; [] N [N -> x] -> [list-of x]
; tabulates F between n and 0 (incl.) in a list
(define (tabulate n F)
  (cond [(= n 0) (list (F 0))]
        [else (cons (F n) (tabulate (sub1 n) F))]))

; Number -> [List-of Number]
; tabulates sin between n and 0 (incl.) in a list

(check-expect (tab-sin0 0) (tab-sin 0))
(check-within (tab-sin0 2) (tab-sin 2) 0.01)

(define (tab-sin0 n)
  (tabulate n sin))

; Number -> [List-of Number]
; tabulates sqrt between n and 0 (incl.) in a list

(check-expect (tab-sqrt0 0) (tab-sqrt 0))
(check-within (tab-sqrt0 2) (tab-sqrt 2) 0.01)

(define (tab-sqrt0 n)
  (tabulate n sqrt))