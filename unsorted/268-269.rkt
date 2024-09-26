;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 268-269) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct IR [name descr price rrp])
; IR (Inventory Record) is
; (make-IR String String Number Number)
; specifies the name of an item, a description, the
; acquisition price, and the recommended sales price.
(define SRPS
  (make-IR "SRPS" "C. baccatum" 2.00 3.29))
(define GATOR-JIGSAW
  (make-IR "Gator Jigsaw" "C. chinense" 1.00 2.89))
(define PRIMOTALII
   (make-IR "Primotalii" "C. chinense" 2.50 3.49))
(define PEPPERS
  (list SRPS GATOR-JIGSAW PRIMOTALII))
;====================================================;
; [List-of IR] -> [List-of IR]
; sorts a list of inventory records by the difference
; between the two prices in ascending order.

(check-expect (short-IR '()) '())
(check-expect (short-IR PEPPERS)
              (list GATOR-JIGSAW SRPS PRIMOTALII))

(define (short-IR l)
  (local (; IR IR -> Boolean
          (define (most-profit? a b)
            (>= (- (IR-rrp a) (IR-price a))
                (- (IR-rrp b) (IR-price b)))))
    ; - IN -
    (sort l most-profit?)))
;====================================================;
; Number [List-of IR] -> [List-of IR]
; produces a list of all those structures whose sales
; price is below ua.

(check-expect (eleminate-expensive 3 PEPPERS)
              (list GATOR-JIGSAW))

(define (eleminate-expensive ua l)
  (local (; IR -> Boolean
          (define (below? ir) (< (IR-rrp ir) ua)))
    ; - IN -
    (filter below? l)))
;====================================================;
; String [List-of IR] -> [List-of IR]
; produces a list of inventory records that do not use
; the name ty.

(check-expect (recall "Primotalii" PEPPERS)
              (list SRPS GATOR-JIGSAW))

(define (recall n l)
  (local (; IR -> Boolean
          (define (name? ir)
            (not (string=? (IR-name ir) n))))
    (filter name? l)))
;====================================================;
; [List-of String] [List-of String]
; -> [List-of String]
; selects all those from the second one that are also
; on the first.

(check-expect (selection (list "dog" "cat" "bunny")
                         (list "bunny" "dog" "frog"))
              (list "bunny" "dog"))

(define (selection la lb)
  (local (; String -> Boolean
          (define (on-a? s) (member? s la)))
    (filter on-a? lb)))