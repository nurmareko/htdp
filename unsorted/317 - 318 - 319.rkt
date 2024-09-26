;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |317 - 318 - 319|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; An S-expr is one of: 
; – Atom
; – SL

; An SL is one of: 
; – '()
; – (cons S-expr SL)

; An Atom is one of: 
; – Number
; – String
; – Symbol
; Atom predicate:
(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))
;=317================================================;
; S-expr Symbol -> N 
; counts all occurrences of sy in sexp

(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

(define (count sexp sy)
  (local (; SL -> N
          (define (count-sl sl)
            (foldr + 0 (map (lambda (s) (count s sy)) sl)))
          ; Atom -> N
          (define (count-atom at)
            (if (and (symbol? at) (symbol=? at sy)) 1 0)))
    (cond
      [(atom? sexp) (count-atom sexp)]
      [else (count-sl sexp)])))
;=318================================================;
; S-expr -> N
; determines sexp depth.
; An Atom has a depth of 1. The depth of a list of
; S-expressions is the maximum depth of its items
; plus 1.

(check-expect (depth 0) 1)
(check-expect (depth "a") 1)
(check-expect (depth 'a) 1)
(check-expect (depth '()) 1)
(check-expect (depth '(0)) 2)
(check-expect (depth '(0 "a" a)) 2)
(check-expect (depth '(0 "a" (a b c))) 3)
(check-expect (depth '((0 (0)) "a" (a b c))) 4)

(define (depth sexp)
  (local (; SL -> N
          (define (depth-sl sl)
            (+ 1 (foldr max 0 (map depth sl)))))
    (cond
      [(atom? sexp) 1]
      [else (depth-sl sexp)])))
;=319================================================;
; S-expr Symbol Symbol -> S-expr
; replace all occurrence of Symbol, old, with
; Symbol, new, on S-expression, s.

(check-expect (substitute 0 'old 'new) 0)
(check-expect (substitute "old" 'old 'new) "old")
(check-expect (substitute 'not 'old 'new) 'not)
(check-expect (substitute 'old 'old 'new) 'new)
(check-expect (substitute '() 'old 'new) '())
(check-expect (substitute '(0 "old" old) 'old 'new) '(0 "old" new))
(check-expect (substitute '(0 old (old 0)) 'old 'new) '(0 new (new 0)))

(define (substitute s old new)
  (local (; S-expr -> S-expr
          (define (subs-sex s)
            (cond
              [(atom? s) (subs-at s)]
              [else (subs-sl s)]))
          ; SL -> SL
          (define (subs-sl sl) (map subs-sex sl))
          ; Atom -> Atom
          (define (subs-at at) (if (equal? old at) new at)))
    (subs-sex s)))