;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |399|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of String] -> [List-of String] 
; picks a random non-identity arrangement of names
(define (gift-pick names)
  (random-pick
    (non-same names (arrangements names))))
 
; [List-of String] -> [List-of [List-of String]]
; returns all possible permutations of names
; see exercise 213
(define (arrangements names)
  ...)
;====================================================;
; [NEList-of X] -> X 
; returns a random item from the list

(check-expect (random-pick '(a)) 'a)
(check-member-of (random-pick '(a b c)) 'a 'b 'c)

(define (random-pick l)
  (list-ref l (random (length l))))
;====================================================;
(define name-ex
  '("Jane" "Dana" "Lisa"))
(define ll-ex
  '(("Jane" "Dana" "Lisa")
    ("Dana" "Jane" "Lisa")
    ("Lisa" "Jane" "Dana")))

; [List-of String] [List-of [List-of String]] 
; -> 
; [List-of [List-of String]]
; produces the list of those lists in ll that do 
; not agree with names at any place

(check-expect (non-same name-ex ll-ex) '(("Lisa" "Jane" "Dana")))

(define (non-same names ll)
    (filter (lambda (x) (item-not-overlap? names x)) ll))

; [X] [NEList-of X] [NEList-of x] -> Boolean
; is A and B not have any equal item at equal index
; position?
(define (item-not-overlap? a b)
  (cond
    [(empty? (rest a)) (not (equal? (first a) (first b)))]
    [else
     (and (not (equal? (first a) (first b)))
          (item-not-overlap? (rest a) (rest b)))]))