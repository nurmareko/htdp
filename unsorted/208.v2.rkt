;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 208.v2) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; LAssocs examples
(define track1
  (list (list "name" "track1")))
(define track2
  (list (list "name" "track2")
        (list "Purchased" #true)))
(define track3
  (list (list "name" "track3")
        (list "Purchased" #true)
        (list "Loved" #true)))

; LLists examples
(define ITUNES-LOCATION "iTunes Music Library.xml")
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))
(define lib
  (list track1
        track2
        track3))

; LLists -> List-of-Strings
; produces the Strings that are associated with a
; Boolean attribute.
(define (boolean-attributes li)
  (create-set
   (key-li (select-all-boolean-type li))))

; LLists -> LAssocs
; produces the list of Assocs with boolean attribute.
(define (select-all-boolean-type li)
  (cond
    [(empty? li) li]
    [else (append (boolean-only (first li))
                (select-all-boolean-type (rest li)))]))

; LAssocs -> LAssocs
; select all boolean type Assocs
(define (boolean-only li)
  (cond
    [(empty? li) li]
    [else (if (boolean? (second (first li)))
              (cons (first li)
                    (boolean-only (rest li)))
              (boolean-only (rest li)))]))

; LAssocs -> List-of-Strings
; create a list of key from LAssocs
(define (key-li li)
  (cond
    [(empty? li) li]
    [else (cons (first (first li))
                (key-li (rest li)))]))

; List-of-Strings -> List-of-Strings
; constructs one that contains every String from the
; given list exactly once.
(define (create-set los)
  [cond
    [(empty? los) los]
    [else (if (member? (first los) (rest los))
              (create-set (rest los))
              (cons (first los) (create-set (rest los))))]])

; tests
(check-expect (boolean-attributes empty)
              empty)
(check-expect (boolean-attributes lib)
              (list "Purchased" "Loved"))
(check-expect
 (select-all-boolean-type empty)
 empty)
(check-expect
 (select-all-boolean-type lib)
 (list (list "Purchased" #true)
       (list "Purchased" #true)
       (list "Loved" #true)))
(check-expect (boolean-only track1)
              empty)
(check-expect (boolean-only track2)
              (list (list "Purchased" #true)))
(check-expect (boolean-only track3)
              (list (list "Purchased" #true)
                    (list "Loved" #true)))
(check-expect (key-li empty)
              empty)
(check-expect (key-li (select-all-boolean-type lib))
              (list "Purchased"
                    "Purchased"
                    "Loved"))