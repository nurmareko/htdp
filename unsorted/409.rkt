;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |409|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

(define reordered-schema
  `(("Age"     ,integer?)
    ("Name"    ,string?)
    ("Present" ,boolean?)))
(define reordered-content
  `((35 "Alice" #true)
    (25 "Bob"   #false)
    (30 "Carol" #true)
    (32 "Dave"  #false)))
(define expect0
  (make-db reordered-schema
           reordered-content))  
;====================================================;
; DB [List-of Label] -> DB
; ...

(check-expect (reorder (make-db '() '()) '())
              (make-db '() '()))
(check-expect (db-content (reorder school-db '("Age" "Name" "Present")))
              (db-content expect0))

(define (reorder db lol)
  (local ((define schema (db-schema db))
          (define content (db-content db))
          (define reordered-schema (for-schema schema lol)))
    (make-db reordered-schema
             (for-content content reordered-schema))))
;=====================================================;
; [List-of Spec] [List-of Label] -> [List-of Spec]
; arrange list of spec base on given list of label
; composition

(check-expect (for-schema '() '()) '())
;(check-expect (for-schema '() '("Age")) '())
(check-expect (for-schema school-schema '()) '())
;(check-expect (for-schema school-schema '("Age" "Name" "Present")) reordered-schema)
(check-expect (for-schema school-schema '("Name" "Age" "Present")) school-schema)
;(check-expect (for-schema ... ...) ...)

(define (for-schema sch lol)
  (cond
    [(empty? lol) '()]
    [else
     (cons (get-spec (first lol) sch)
           (for-schema sch (rest lol)))]))

; String [List-of Spec] -> Spec
; get spec with given label on given schema

(check-expect (first (get-spec "Name" school-schema)) (first `("Name" ,string?)))
(check-error (get-spec "Grade" school-schema))

(define (get-spec label sch)
  (cond
    [(empty? sch) (error "not found")]
    [else
     (if (equal? label (first (first sch)))
         (first sch)
         (get-spec label (rest sch)))]))
;=====================================================;
; [List-of Row] [List-of Spec] -> [List-of Row]
; ...

(check-expect (for-content school-content reordered-schema) reordered-content)

(define (for-content cont sch)
  (cond
    [(empty? cont) '()]
    [else
     (cons (arrange-row (first cont) sch)
           (for-content (rest cont) sch))]))

; Row Schema -> row
; rearrange row base given schema

(check-expect (arrange-row `("Alice" 35 #true) reordered-schema) `(35 "Alice" #true))

(define (arrange-row row sch)
  (cond
    [(empty? sch) '()]
    {else
     (cons (find-value (first sch) row)
           (arrange-row row (rest sch)))}))

; Spec Row -> Cell
; ...

(check-expect (find-value `("Age" ,integer?) `("Alice" 35 #true)) 35)
(check-expect (find-value `("Name" ,string?) `("Alice" 35 #true)) "Alice")
(check-expect (find-value `("Present" ,boolean?) `("Alice" 35 #true)) #true)
(check-error (find-value `("Present" ,symbol?) `("Alice" 35 #true)))

(define (find-value spec row)
  (cond
    [(empty? row) (error "not found")]
    [else
     (if ((second spec) (first row))
         (first row)
         (find-value spec (rest row)))]))
         