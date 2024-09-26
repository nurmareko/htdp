;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |403|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)
 
; A Schema is a [List-of Spec]
(define-struct spec [label predicate])
; Spec is a structure: (make-spec Label Predicate)
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

(define presence-schema
  `(,(make-spec "Present"     boolean?)
    ,(make-spec "Description" string?)))

(define presence-content
  `((#true  "presence")
    (#false "absence")))
	
(define presence-db
  (make-db presence-schema
           presence-content))

(define faulty-db
  (make-db presence-schema
           school-content))
;====================================================;
(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))
 
(define projected-schema
  `(,(make-spec "Name"    string?)
    ,(make-spec "Present" boolean?)))
 
(define projected-db
  (make-db projected-schema projected-content))
;  Stop! Read this test carefully. What's wrong?
(check-expect (project school-db '("Name" "Present"))
              projected-db)
;====================================================;
; DB -> Boolean
; do all rows in db satisfy (I1) and (I2)
 
(check-expect (integrity-check school-db) #true)
(check-expect (integrity-check presence-db) #true)
(check-expect (integrity-check faulty-db) #false)
 
(define (integrity-check db)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
          (define width   (length schema))
          ; Row -> Boolean 
          ; does row satisfy (I1) and (I2) 
          (define (row-integrity-check row)
            (and (= (length row) width)
                 (andmap (lambda (s c)
                           [(spec-predicate s) c])
                         schema row))))
    (andmap row-integrity-check content)))
;====================================================;
; DB [List-of Label] -> DB
; retains a column from db if its label is in labels
(define (project db labels)
  (local ((define schema  (db-schema db))
          (define content (db-content db))
          ; Spec -> Boolean
          ; does this spec belong to the new schema
          (define (keep? c) ...)
          ; Row -> Row
          ; retains those columns whose name is in labels
          (define (row-project row) ...))
    (make-db (filter keep? schema)
             (map row-project content))))