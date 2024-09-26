;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Relations) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; [Pair -> Boolean] [List-of Pair] -> [List-of Pair]
; keep element of cp according to f.

(check-expect (relation formula1 '()) '())
(check-expect (relation formula1 '((1 3)(1 4)(2 3)(2 4)))
              '((1 3) (1 4) (2 4)))

(define (relation f cp)
  (filter f cp))
;====================================================;
; [List-of Number] [List-of Number] -> [List-of Pair]

(check-expect (cartesian-product '() '(3 4)) '())
(check-expect (cartesian-product '(1 2) '(3 4)) '((1 3) (1 4) (2 3) (2 4)))

(define (cartesian-product a b)
  (foldr (lambda (x re)
           (append (map (lambda (y) (list x y)) b) re))
         '() a))
;====================================================;
; Pair -> Boolean
; is (second p) divided (first p) equal to integer?

(check-expect (formula1 '(4 6)) #false)
(check-expect (formula1 '(4 8)) #true)

(define (formula1 p)
  (integer? (/ (second p) (first p))))

(define (formula2 p)
  (integer? (- (/ 1 (first p)) (/ 1 (second p)))))

(define (formula3 p)
  (integer? (/ (- (first p) (second p)) 3)))

(define (formula4 p)
  (integer? (/ (- (first p) (second p)) 4)))

(define (formula6 p)
  (= (second p) (sqr (first p))))
;====================================================;
;[List-of Pair] -> Set-Roster
; translate list of pair into set roster notation.

(check-expect (set-roster '()) "{}")
(check-expect (set-roster '((4 6) (4 8)))
              "{(4, 6), (4, 8)}")

(define (set-roster lp)
  (local (;[List-of Pair] -> Set-Roster
          (define (set-roster lp)
            (cond
              [(empty? lp) ""]
              [else
               (string-append
                "(" (number->string (first (first lp))) ", "
                (number->string (second (first lp))) (if (empty? (rest lp)) ")" "), ")
                (set-roster (rest lp)))])))
    (string-append "{" (set-roster lp) "}")))
;====================================================;
; [Pair -> Boolean] [List-of Number] [List-of Number]
; -> Set-Roster
; translate.
(define (translate f a b)
  (set-roster (relation f (cartesian-product a b))))

(translate
 (lambda (x)
   (= (- (second x) 1) (/ (first x) 2)))
 '(2 4) '(1 3 5))