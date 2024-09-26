;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |17.4 wtf|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [X] [List-of X] [X X -> Boolean] -> [List-of X]
; sorts alon0 according to cmp
 
(check-satisfied (sort-cmp '("c" "b") string<?)
                 (sorted string<?))
(check-satisfied (sort-cmp '(2 1 3 4 6 5) <)
                 (sorted <))
 
; [List-of Number] [Number Number -> Boolean] 
; -> [List-of Number]
; produces a version of alon0, sorted according to cmp
(define (sort-cmp alon0 cmp)
  (local (; [List-of Number] -> [List-of Number]
          ; produces the sorted version of alon
          (define (isort alon)
            (cond
              [(empty? alon) '()]
              [else
               (insert (first alon) (isort (rest alon)))]))
 
          ; Number [List-of Number] -> [List-of Number]
          ; inserts n into the sorted list of numbers alon 
          (define (insert n alon)
            (cond
              [(empty? alon) (cons n '())]
              [else (if (cmp n (first alon))
                        (cons n alon)
                        (cons (first alon)
                              (insert n (rest alon))))])))
    (isort alon0)))
;====================================================;
; [X X -> Boolean] -> [[List-of X] -> Boolean]
; is the given list l0 sorted according to cmp?

(check-expect [(sorted string<?) '("b" "c")] #true)
(check-expect [(sorted string<?) '()] #true)
(check-expect [(sorted <) '(1 2 3 4 5 6)] #true)

(define (sorted cmp)
  (lambda (l0)
    (if (empty? l0) #true (sorted? cmp l0))))
;====================================================;
; [X X -> Boolean] [NEList-of X] -> Boolean 
; determines whether l is sorted according to cmp
 
(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(2 1 3)) #false)

(define (sorted? cmp l)
  (cond
    [(empty? (rest l)) #true]
    [else (and (cmp (first l) (second l))
               (sorted? cmp (rest l)))]))
;====================================================;
; List-of-numbers -> List-of-numbers
; produces a sorted version of l

;(check-expect (sort-cmp/bad '( 2 1 3)) '(1 2 3))

(define (sort-cmp/bad l)
 '(9 8 7 6 5 4 3 2 1 0))
;====================================================;
; [X] [List-of X] [X X -> Boolean] -> [[List-of X] -> Boolean]
; is l0 sorted according to cmp
; are all items in list k members of list l0

(check-expect [(sorted-variant-of '(3 2) <) '(2 3)]
              #true)
(check-expect [(sorted-variant-of '(3 2) <) '(3)]
              #false)

(define (sorted-variant-of k cmp)
  (lambda (l0)
    (and (sorted? cmp l0)
         (contains? k l0)
         (contains? l0 k))))
;====================================================;
; [X] [List-of X] [List-of X] -> Boolean 
; are all items in list k members of list l
 
(check-expect (contains? '(1 2 3) '(1 4 3)) #false)
(check-expect (contains? '(1 2 3 4) '(1 3)) #true)
 
(define (contains? l k)
  (andmap (lambda (in-k) (member? in-k l)) k))
;====================================================;
; [List-of Number] -> [List-of Number] 
; produces a sorted version of l

;(check-expect (sort-cmp/worse '(1 2 3)) '(1 2 3))
;(check-satisfied (sort-cmp/worse '(1 2 3))
;                 (sorted-variant-of '(1 2 3) <))

(define (sort-cmp/worse l)
  (local ((define sorted (sort-cmp l <)))
    (cons (- (first sorted) 1) sorted)))

