;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |410|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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
 
(define content-a
  `(("Alice"  35 #true)
    ("Bob"    25 #false)
    ("Carol"  30 #true)
    ("Dave"   32 #false)))

(define content-b
  `(("Carol"  30 #true)
    ("Jack"   27 #true)
    ("Dave"   32 #false)
    ("Daniel" 22 #true)))

(define content-joined
  `(("Alice"  35 #true)
    ("Bob"    25 #false)
    ("Carol"  30 #true)  
    ("Jack"   27 #true)
    ("Dave"   32 #false)
    ("Daniel" 22 #true)))

(define db-a
  (make-db school-schema
           content-a))

(define db-b
  (make-db school-schema
           content-b))
;====================================================;
; DB DB -> DB
; produces a new database with this schema and the
; joint content of both

(check-expect (union-db db-a (make-db school-schema '()))
 db-a)
(check-expect (union-db db-a db-b)
              (make-db school-schema content-joined))

(define (union-db a b)
  (local ((define schema (db-schema a))
          (define content-a (db-content a))
          (define content-b (db-content b))
          ;Content Content -> Content
          (define (union sa sb)
            (foldr (lambda (a b) (if (member? a b) b (cons a b))) sb sa)))
    (make-db schema (union content-a content-b))))
