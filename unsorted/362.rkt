;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |362|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name argument])
(define-struct def [name parameter body])
(define-struct con [name body])
(define WRONG "WRONG")
;====================================================;
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
(define (atom? v)
  (or (number? v) (string? v) (symbol? v)))
;====================================================;
; A BSL-expr is one of: 
; – Number
; - Symbol
; – Add
; – Mul
; - Fun
(define (bsl-expr? v)
  (or (number? v) (symbol? v) (add? v) (mul? v) (fun? v)))

; A BSL-da is a list
;  [list-of Def]

; A Def is one of:
; - Fun-def
; - Con-def

; Add is a structure
;  (make-add BSL-expr BSL-expr)
; Mul is a structure
;  (make-mul BSL-expr BSL-expr)
; Fun is a structure
;  (make-fun Symbol BSL-expr)
; A Fun-def is a structure
;  (make-def [Symbol Symbol BSL-expr])
; A Con-def is a structure
;  (make-con [Symbol BSL-expr]
;====================================================;
(define con0
  '(define close-to-pi 3.14))
 
(define def0
  '(define (area-of-circle r)
     (* close-to-pi (* r r))))
 
(define def1
  '(define (volume-of-10-cylinder r)
     (* 10 (area-of-circle r))))

(define da-all
  (list con0 def0 def1))
;====================================================;
; S-expr SL -> Value
; interpret S-expression, sex, as BSL-expression and
; list of S-expression, sl, as BSL-definitionArea
; and produce its value

(check-expect (interpreter 5 da-all) 5)
(check-error (interpreter "5" da-all) WRONG)
(check-error (interpreter 'five da-all) WRONG)
(check-expect (interpreter 'close-to-pi da-all) 3.14)

(check-expect (interpreter '(+ 5 5) da-all) 10)
(check-expect (interpreter '(* 5 5) da-all) 25)
(check-error (interpreter '(- 5 5) da-all) WRONG)

(check-expect (interpreter '(area-of-circle 5) da-all) 78.5)
(check-expect (interpreter '(volume-of-10-cylinder 5) da-all) 785)
(check-error (interpreter '(f 5) da-all) WRONG)

(define (interpreter sex sl)
  (eval-all (parse-x sex) (parse-d sl)))
;====================================================;
; S-expr -> BSL-expr
; partse s-expression, sex, into BSL-expr

(check-expect (parse-x 5) 5)
(check-expect (parse-x 'five) 'five)
(check-expect (parse-x 'close-to-pi) 'close-to-pi)
(check-error (parse-x "5") WRONG)

(check-expect (parse-x '(+ 5 5)) (make-add 5 5))
(check-expect (parse-x '(* 5 5)) (make-mul 5 5))
(check-error (parse-x '(- 5 5)) WRONG)
(check-error (parse-x '(+ 5 5 5)) WRONG)

(check-expect (parse-x '(area-of-circle 5)) (make-fun 'area-of-circle 5))
(check-expect (parse-x '(volume-of-10-cylinder 5)) (make-fun 'volume-of-10-cylinder 5))
(check-expect (parse-x '(f 5)) (make-fun 'f 5))
(check-error (parse-x '()) WRONG)
(check-error (parse-x (list #true)) WRONG)
(check-error (parse-x #true) WRONG)

(define (parse-x sex)
  (cond
    [(atom? sex)
     (if (or (number? sex) (symbol? sex)) sex (error WRONG))]
    [else
     (cond
       [(empty? sex) (error WRONG)]
       [(list? sex)
        (cond
          [(add-sl? sex)
           (make-add (parse-x (second sex)) (parse-x (third sex)))]
          [(mul-sl? sex)
           (make-mul (parse-x (second sex)) (parse-x (third sex)))]
          [(fun-sl? sex)
           (make-fun (first sex) (parse-x (second sex)))]
          [else (error WRONG)])]
       [else (error WRONG)])]))

; SL -> Boolean
(define (add-sl? sl)
  (and (= (length sl) 3) (symbol? (first sl)) (symbol=? '+ (first sl))))
; SL -> Boolean
(define (mul-sl? sl)
  (and (= (length sl) 3) (symbol? (first sl)) (symbol=? '* (first sl))))
; SL -> Boolean
(define (fun-sl? sl)
  (and (= (length sl) 2) (symbol? (first sl))))
;====================================================;
; SL -> BSL-da
; parse list of s-expression, lsex, into BSL-da

(check-expect (parse-d '()) '())
(check-error (parse-d '(5)) WRONG)
(check-error (parse-d '("5")) WRONG)
(check-error (parse-d '(five)) WRONG)
(check-error (parse-d '(())) WRONG)

(check-expect (parse-d (list '(define number 5))) (list (make-con 'number 5)))
(check-expect (parse-d (list '(define (f x) x))) (list (make-def 'f 'x 'x)))
(check-error (parse-d (list '(define (f x) x) '(define number 5) 'a)) WRONG)
(check-error (parse-d (list '(def (f x) x))) WRONG)
(check-error (parse-d (list '(define f x x))) WRONG)

(define (parse-d sl)
  (cond
    [(empty? sl) sl]
    [else
     (cond
       [(con-sl? (first sl))
        (cons (make-con (second (first sl)) (parse-x (third (first sl))))
              (parse-d (rest sl)))]
       [(def-sl? (first sl))
        (cons (make-def (first (second (first sl))) (second (second (first sl))) (parse-x (third (first sl))))
              (parse-d (rest sl)))]
       [else (error WRONG)])]))

; S-expr -> Boolean
(define (con-sl? sex)
  (and (list? sex)
       (= (length sex) 3)
       (symbol? (first sex))
       (symbol=? 'define (first sex))
       (symbol? (second sex))))

; S-expr -> Boolean
(define (def-sl? sex)
  (and (list? sex)
       (= (length sex) 3)
       (symbol? (first sex))
       (symbol=? 'define (first sex))
       (list? (second sex))
       (symbol? (first (second sex)))
       (symbol? (second (second sex)))))
;====================================================;
;BSL-expr BSL-da-all -> Number
; evaluate given expression value.
(define (eval-all ex da)
  (local(; BSL-expr -> Number
         (define (for-expr ex)
           (cond
             [(number? ex) ex]
             [(symbol? ex) (for-symbol ex)]
             [(add? ex) (for-add ex)]
             [(mul? ex) (for-mul ex)]
             [(fun? ex) (for-fun ex)]
             [else (error WRONG)]))
         ; Symbol -> Number
         (define (for-symbol ex)
           (local ((define defined (lookup-con-def da ex))
                   (define subst (con-body defined)))
             (for-expr subst)))
         ; Add -> Number
         (define (for-add ex)
           (+ (for-expr (add-left ex))
              (for-expr (add-right ex))))
         ; Mul -> Number
         (define (for-mul ex)
           (* (for-expr (mul-left ex))
              (for-expr (mul-right ex))))
         ; Fun -> Number
         (define (for-fun ex)
           (local ((define defined (lookup-fun-def da (fun-name ex)))
                   (define plugd
                     (subst (def-body defined)
                            (def-parameter defined)
                            (fun-argument ex))))
             (for-expr plugd))))
    (for-expr ex)))
;====================================================;
; BSL-da-all Symbol -> Con-def
; produces the representation of a constant definition
; whose name is x, if such a piece of data exists
; in da.
(define (lookup-con-def da x)
  (if (empty? da)
      (error WRONG)
      (if (and (con? (first da))
               (symbol=? x (con-name (first da))))
          (first da)
          (lookup-con-def (rest da) x))))
;====================================================;
; BSL-da-all Symbol -> Fun-def
; produces the representation of a constant definition
; whose name is x, if such a piece of data exists
; in da.
(define (lookup-fun-def da x)
  (if (empty? da)
      (error WRONG)
      (if (and (def? (first da))
               (symbol=? x (def-name (first da))))
          (first da)
          (lookup-fun-def (rest da) x))))
;====================================================;
; BSL-expr Symbol BSL-expr -> Number
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (equal? ex x) v ex)]
    [(add? ex)
     (make-add (subst (add-left ex) x v)
               (subst (add-right ex) x v))]
    [(mul? ex)
     (make-mul (subst (mul-left ex) x v)
               (subst (mul-right ex) x v))]
    [(fun? ex)
     (make-fun (fun-name ex)
               (subst (fun-argument ex) x v))]))