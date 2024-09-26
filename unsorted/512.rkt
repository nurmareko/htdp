;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |512|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Lam is one of: 
; – a Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)

(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) (x x)) (λ (x) (x x))))
(define ex5 '((λ (x) x) (λ (x) x)))
(define ex6 '(((λ (y) (λ (x) y)) (λ (z) z)) (λ (w) w)))
;====================================================;
; Any -> Boolean
; is x a variable?

(check-expect (is-var? 'x) #true)
(check-expect (is-var? 'y) #true)
(check-expect (is-var? 0) #false)
(check-expect (is-var? '(x y)) #false)

(define (is-var? x) (symbol? x))

; Any -> Boolean
; is x an expression?

(check-expect (is-λ? ex1) #true)
(check-expect (is-λ? ex2) #true)
(check-expect (is-λ? ex3) #true)
(check-expect (is-λ? ex4) #false)
(check-expect (is-λ? ex5) #false)
(check-expect (is-λ? ex6) #false)
(check-expect (is-λ? 'x)  #false)

(define (is-λ? x)
  (and
   (list? x)
   (= 3 (length x))
   (equal? 'λ (first x))
   (list? (second x))
   (or (is-var? (third x))
       (is-λ?   (third x))
       (is-app? (third x)))))
       
; Any -> Boolean
; is x an application?

(check-expect (is-app? ex1) #false)
(check-expect (is-app? ex2) #false)
(check-expect (is-app? ex3) #false)
(check-expect (is-app? 'x)  #false)
(check-expect (is-app? ex4) #true)
(check-expect (is-app? ex5) #true)
(check-expect (is-app? ex6) #true)
(check-expect (is-app? '(x (y z))) #true)

(define (is-app? x)
  (and
   (list? x)
   (= 2 (length x))
   (or (is-var? (first x))
       (is-λ?   (first x))
       (is-app? (first x)))
   (or (is-var? (second x))
       (is-λ?   (second x))
       (is-app? (second x)))))
;====================================================;
; Lam -> Symbol
; extracts the parameter from a λ expression.

(check-expect (λ-para ex1) 'x)

(define (λ-para lam) (first (second lam)))

; Lam -> Lam
; extracts the body from a λ expression.

(check-expect (λ-body ex3) '(λ (x) y))

(define (λ-body lam) (third lam))

; Lam -> Lam
; extracts the function from an application.

(check-expect (app-fun ex4) '(λ (x) (x x)))

(define (app-fun lam) (first lam))

; Lam -> Lam
; extracts the argument from an application.

(check-expect (app-arg ex5) '(λ (x) x))

(define (app-arg lam) (second lam))
;====================================================;
; Lam -> [List-of Symbol]
; produces the list of all symbols used as λ
; parameters in a λ term.

(check-expect (declareds ex1) '(x))
(check-expect (declareds ex2) '(x))
(check-expect (declareds ex4) '(x x))
(check-expect (declareds ex5) '(x x))
(check-expect (declareds ex3) '(y x))
(check-expect (declareds ex6) '(y x z w))

(define (declareds lam)
  (cond
    [(is-var? lam) '()]
    [(is-λ? lam)
     (cons (λ-para lam)
           (declareds (λ-body lam)))]
    [(is-app? lam)
     (append (declareds (app-fun lam))
             (declareds (app-arg lam)))]))
