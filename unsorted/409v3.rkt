;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 409v3) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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
 
(define school-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define school-db
  (make-db school-schema
           school-content))
;====================================================;
; DB [List-of Label] -> DB
; produces a database like db but with its columns
; reordered according to lol

;(check-expect (reorder (make-db '() '()) '())
;              (make-db '() '()))
;(check-expect (db-content (reorder school-db '("Age" "Name" "Present")))
;              (db-content expect0))
;
;(define (reorder db lol)
;  (local ((define schema (db-schema db))
;          (define content (db-content db))
;
;          ; [List-of Label] -> [List-of Spec]
;          (define (build-schema lol)
;            (map (lambda (label)
;                   (foldr (lambda (spec re)
;                            (if (equal? label (first spec)) spec re))
;                          #false
;                          schema))
;                 lol)))
;    
;    (make-db (build-schema lol)
;             (build-contet ncontent)))
;====================================================;
 ; [List-of Spec] [List-of Label] -> [List-of Spec]

(check-expect (map first (build-schema '("Present" "Name" "Age") school-schema))
              '("Present" "Name" "Age"))

(define (build-schema lol schema)
  (map (lambda (label)
         (foldr (lambda (spec re)
                  (if (equal? label (first spec)) spec re))
                #false
                schema))
       lol))

;(define (build-schema lol schema)
;  (local (; Label -> Spec
;          (define (fun label)
;            (find label schema)))
;    (map fun lol)))
;====================================================;
; [List-of Row] [List-of Schema] -> [List-of Row]

(check-expect (for-content school-content '("Present" "Name" "Age"))
              `((#true  "Alice" 35)
                (#false "Bob"   25)
                (#true  "Carol" 30)
                (#false "Dave"  32)))

(define (build-content content lol)
  (map (lambda (row)
         (map (lambda (spec)
                (foldr (lambda (cell re) (if ((second spec) cell) cell re))
                       #false
                       row))
              sch))
       cont)
