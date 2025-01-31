;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |515|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Lam is one of: 
; – a Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)
(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) (x x)) (λ (x) (x x))))
(define ex515
  '(λ (*undeclared) ((λ (x) (x *undeclared)) y)))
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
; Lam -> Lam 
; replaces all symbols s in le with '*undeclared
; if they do not occur within the body of a λ 
; expression whose parameter is s

(check-expect (undeclareds ex1) '(λ (x) *declared:x))
(check-expect (undeclareds ex2) '(λ (x) *undeclared:y))
(check-expect (undeclareds ex3) '(λ (y) (λ (x) *declared:y)))
(check-expect (undeclareds ex4)
              '((λ (x) (*declared:x *declared:x)) (λ (x) (*declared:x *declared:x))))
(check-expect (undeclareds ex515)
              '(λ (*undeclared) ((λ (x) (*declared:x *declared:*undeclared)) *undeclared:y)))

(define (undeclareds le0)
  (local (; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds)
                   (string->symbol (string-append "*declared:" (symbol->string le)))
                   (string->symbol (string-append "*undeclared:" (symbol->string le))))]
              [(is-λ? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (list 'λ (list para)
                       (undeclareds/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
                 (list (undeclareds/a fun declareds)
                       (undeclareds/a arg declareds)))])))
    (undeclareds/a le0 '())))
;====================================================;
; (undeclareds ex515) before modified
; ==
; '(λ (*undeclared) ((λ (x) (x *undeclared)) *undeclared))
 