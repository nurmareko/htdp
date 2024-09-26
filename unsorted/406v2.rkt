;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 406v2) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)
 
; A Schema is a [List-of Spec]
(define-struct spec [label predicate])
; A Spec is a structure: (make-spec Label Predicate)
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
  `(,(make-spec "Name"    string?)
    ,(make-spec "Age"     integer?)
    ,(make-spec "Present" boolean?))) 

(define school-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define school-db
  (make-db school-schema
           school-content))
;====================================================;
(define presence-schema
  `(,(make-spec "Present"     boolean?)
    ,(make-spec "Description" string?)))

(define presence-content
  `((#true  "presence")
    (#false "absence")))

(define presence-db
  (make-db presence-schema
           presence-content))
;====================================================;
(define faulty-school-content
  `(("Alice" 35 #true)
    (25   "Bob" #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))
;====================================================;
; DB -> Boolean
; do all rows in db satisfy (I1) and (I2)
 
(check-expect (integrity-check school-db) #true)
(check-expect (integrity-check presence-db) #true)
(check-expect (integrity-check (make-db school-schema presence-content)) #false)
(check-expect (integrity-check (make-db school-schema faulty-school-content)) #false)

(define (integrity-check db)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
          (define width   (length schema))
          ; Row -> Boolean 
          ; does row satisfy (I1) and (I2) 
          (define (row-integrity-check row)
            (and (= (length row) width)
                 (andmap (lambda (s c) [(spec-predicate s) c])
                         schema
                         row))))
    (andmap row-integrity-check content)))
;====================================================;
; DB [List-of Label] -> DB
; retains a column from db if its label is in labels

(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))
 
(define projected-schema
  `(("Name" ,string?) ("Present" ,boolean?)))
 
(define projected-db
  (make-db projected-schema projected-content))
(check-expect
  (db-content (project school-db '("Name" "Present")))
  projected-content)

(define (project db labels)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
 
          ; Spec -> Boolean
          ; does this column belong to the new schema
          (define (keep? c)
            (member? (spec-label c) labels))
 
          ; Row -> Row 
          ; retains those columns whose name is in labels
          (define (row-project row)
            (foldr (lambda (cell m c) (if m (cons cell c) c))
                   '()
                   row
                   mask))
          (define mask (map keep? schema)))
    (make-db (filter keep? schema)
             (map row-project content))))
