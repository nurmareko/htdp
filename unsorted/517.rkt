;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |517|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Lam is one of: 
; – Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)

; A Lam-N is one of
; – N
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)

(define example '((λ (x) ((λ (y) (y x)) x)) (λ (z) z)))
(define expected-result '((λ (x) ((λ (y) (0 1)) 0)) (λ (z) 0)))
;====================================================;
; Any -> Boolean
; is x a variable?
(define (is-var? x) (symbol? x))

; Any -> Boolean
; is x an expression?
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

; Lam -> Symbol
; extracts the parameter from a λ expression.
(define (λ-para lam) (first (second lam)))

; Lam -> Lam
; extracts the body from a λ expression.
(define (λ-body lam) (third lam))

; Lam -> Lam
; extracts the function from an application.
(define (app-fun lam) (first lam))

; Lam -> Lam
; extracts the argument from an application.
(define (app-arg lam) (second lam))
;====================================================;
; Lam -> Lam-N
; replaces all occurrences of variables with a natural
; number that represents how far away the declaring λ is.

(check-expect (static-distance example) expected-result)

(define (static-distance le0)
  (local (; Lam [List-of Symbol] -> Lam-N
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (static-distance/a le declareds)
            (cond
              [(is-var? le)
               (local (; Symbol -> N
                       ; get the distance of var.
                       (define (var-distance var dec)
                         (cond
                           [(equal? var (first dec)) 0]
                           [else
                            (+ 1 (var-distance var (rest dec)))])))
                 (var-distance le declareds))]
              [(is-λ? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (list 'λ (list para)
                       (static-distance/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
                 (list (static-distance/a fun declareds)
                       (static-distance/a arg declareds)))])))
    (static-distance/a le0 '())))
