;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |411|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)
 
; A Schema is a [List-of Spec]
; A Spec is a [List Label Predicate]
; A Label is a String
; A Predicate is a [Any -> Boolean]
 
; A (piece of) Content is a [List-of Row]
; A Row is a [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions 
 
; integrity constraint In (make-db sch con), 
; for every row in con,
; (I1) its length is the same as sch's, and
; (I2) its ith Cell satisfies the ith Predicate in sch
;====================================================;
(define school-schema
  `(("Name"    ,string?)
    ("Age"     ,integer?)
    ("Present" ,boolean?)))

(define presence-schema
  `(("Present"     ,boolean?)
    ("Description" ,string?)))

(define school-content
  `(("Alice"  35 #true)
    ("Bob"    25 #false)
    ("Carol"  30 #true)
    ("Dave"   32 #false)))

(define presence-content
  `((#true  "presence")
    (#true  "here")
    (#false "absence")
    (#false "there")))

(define school-db
  (make-db school-schema
           school-content))

(define presence-db
  (make-db presence-schema
           presence-content))
;====================================================;
; DB DB -> DB
; ...

(check-expect (db-content (join school-db presence-db))
              `(("Alice"  35 "presence")
                ("Alice"  35 "here")
                ("Bob"    25 "absence")
                ("Bob"    25 "there")
                ("Carol"  30 "presence")
                ("Carol"  30 "here")
                ("Dave"   32 "absence")
                ("Dave"   32 "there")))

(define (join db-1 db-2)
  (local ((define schema-1 (db-schema db-1))
          (define schema-2 (db-schema db-2))
          (define content-1 (db-content db-1))
          (define content-2 (db-content db-2))
          ; Content Content -> Content
          (define (build-content cont-a cont-b)
            (foldr (lambda (row re)
                     (append
                      (foldr (lambda (r re)
                               (if (member? (first r) row) (cons (build row r) re) re))
                             '()
                             cont-b)
                      re))
                   '()
                   cont-a)))
    (make-db (build schema-1 schema-2)
             (build-content content-1 content-2))))
;====================================================;        
; [List-of X] [List-of Y] -> [List-of Z]
(define (build a b)
  (cond
    [(empty? a) b]
    [else
     (if (member? (first a) b)
         (build (rest a) (rest b))
         (cons (first a) (build (rest a) b)))]))