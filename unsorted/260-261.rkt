;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 260-261) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct IR
  [name price])
; An IR is a structure:
;   (make-IR String Number)
; An Inventory is one of: 
; – '()
; – (cons IR Inventory)
(define toysland
  (list (make-IR "hotwheels-x" 5)
        (make-IR "doggy-doll" 0.7)
        (make-IR "play-doh" 0.7)
        (make-IR "puzzle" 0.7)
        (make-IR "hotwheels-y" 5)
        (make-IR "panda-friend" 0.7)
        (make-IR "hotwheels-z" 5)
        (make-IR "hotwheels-1" 5)
        (make-IR "gunny" 0.7)
        (make-IR "hotwheels-2" 5)))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (IR-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1.v2 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (local ((define first-item (first an-inv))
             (define extrac-rest (extract1 (rest an-inv))))
       (cond
         [(<= (IR-price first-item) 1.0)
          (cons first-item extrac-rest)]
         [else extrac-rest]))]))
  