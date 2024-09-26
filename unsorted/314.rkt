;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |314|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-person [])
(define-struct person [father mother name date eyes])
(define NP (make-no-person))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; An FF is a [List-of FT]

; Oldest Generation:
(define Carl
  (make-person NP NP "Carl" 1926 "green"))
(define Bettina
  (make-person NP NP "Bettina" 1926 "green"))
; Middle Generation:
(define Adam
  (make-person Carl Bettina "Adam" 1950 "hazel"))
(define Dave
  (make-person Carl Bettina "Dave" 1955 "black"))
(define Eva
  (make-person Carl Bettina "Eva" 1965 "blue"))
(define Fred
  (make-person NP NP "Fred" 1966 "pink"))
; Youngest Generation: 
(define Gustav
  (make-person Fred Eva "Gustav" 1988 "brown"))
; Family Forest:
(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))
;====================================================;
; FF -> Boolean
; does the forest contain any child with "blue" eyes
 
(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)

(define (blue-eyed-child-in-forest? a-forest)
  (ormap blue-eyed-person? a-forest))

; FT -> Boolean
; does an-ftree contain a child
; structure with "blue" in the eyes field

(check-expect (blue-eyed-person? Carl) #false)
(check-expect (blue-eyed-person? Gustav) #true)

(define (blue-eyed-person? an-ftree)
  (cond
    [(no-person? an-ftree) #false]
    [else (or (string=? (person-eyes an-ftree) "blue")
              (blue-eyed-person?
               (person-father an-ftree))
              (blue-eyed-person?
               (person-mother an-ftree)))]))
;====================================================;
; FF Number -> Number
; produces the average age of all person instances in
; the forest.

(check-expect (average-age '() 2022) 0)
(check-expect (average-age ff1 2022) 96)
(check-expect (average-age ff2 2022) 76.25)
(check-expect (average-age ff3 2022) 80.2)

(check-expect (average-age ff1 2018)    92)
(check-expect (average-age ff2 2018) 72.25)
(check-expect (average-age ff3 2018)  76.2)

(check-expect (average-age ff1 2019) 93)
(check-expect (average-age ff2 2019) 73.25)
(check-expect (average-age ff3 2019) 77.2)

(define (average-age ff yr)
  (cond
    [(empty? ff) 0]
    [else (local ((define total-age
                    (foldr + 0 (all-ff-age ff yr)))
                  (define total-person
                    (length (remove-all 0 (all-ff-age ff yr)))))
            (/ total-age total-person))]))

; FF Number -> Number
; list all person age on tt
(define (all-ff-age ff yr)
  (cond
    [(empty? ff) '()]
    [else (append (persons-age (first ff) yr)
                  (all-ff-age (rest ff) yr))]))

; FT Number -> [List-of Number]
; list all person age on ft
(define (persons-age ft yr)
  (cond
    [(no-person? ft) '()]
    [else
     (append (list (- yr (person-date ft)))
             (persons-age (person-father ft) yr)
             (persons-age (person-mother ft) yr))]))