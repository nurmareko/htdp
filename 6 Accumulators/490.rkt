;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |490|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> [List-of Number]
; converts a list of relative to absolute distances
; the first number represents the distance to the
; origin
(define (relative->absolute l)
  (cond
    [(empty? l) '()]
    [else
     (local ((define rest-of-l
               (relative->absolute (rest l)))
             (define adjusted
               (add-to-each (first l) rest-of-l)))
            (cons (first l) adjusted))]))
 
; Number [List-of Number] -> [List-of Number]
; adds n to each number on l
 (define (add-to-each n l)
   (map (lambda (i) (+ i n)) l))

; relative->absolute use 'n' recursive call to
; relative->absulute and 'n' call to add-to-each
; where 'n' is the length of the input list,
; therefore the abstract running time of
; relative->absolute is O(n^2) because the number of
; recursion is the same as its input length and
; realive->absolute traverse for every item in the
; list and add-to-each also takes n time to get its
; result.