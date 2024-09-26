;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |310 - 311 - 312 - 313|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-person [])
(define-struct person [father mother name date eyes])
(define NP (make-no-person))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-person NP NP "Carl" 1926 "green"))
(define Bettina (make-person NP NP "Bettina" 1926 "green"))
; Middle Generation:
(define Adam (make-person Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-person Carl Bettina "Dave" 1955 "black"))
(define Eva (make-person Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-person NP NP "Fred" 1966 "pink"))
; Youngest Generation: 
(define Gustav (make-person Fred Eva "Gustav" 1988 "brown"))
;====================================================;
; FT -> ???
; ...
;(define (fun-FT an-ftree)
;  (cond
;    [(no-parent? an-ftree) ...]
;    [else (... (fun-FT (child-father an-ftree)) ...
;           ... (fun-FT (child-mother an-ftree)) ...
;           ... (child-name an-ftree) ...
;           ... (child-date an-ftree) ...
;           ... (child-eyes an-ftree) ...)]))
;====================================================;
; FT -> Boolean
; does an-ftree contain a child
; structure with "blue" in the eyes field

(check-expect (blue-eyed-person? Carl) #false)
(check-expect (blue-eyed-person? Gustav) #true)

(define (blue-eyed-person? an-ftree)
  (cond
    [(no-person? an-ftree) #false]
    [else (or (string=? (person-eyes an-ftree) "blue")
              (blue-eyed-person? (person-father an-ftree))
              (blue-eyed-person? (person-mother an-ftree)))]))
;====================================================;
; FT -> Number
; counts the child structures in the tree.

(check-expect (count-persons NP) 0)
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Adam) 3)
(check-expect (count-persons Gustav) 5)

(define (count-persons an-ftree)
  (cond
    [(no-person? an-ftree) 0]
    [else (+ 1
             (count-persons (person-father an-ftree))
             (count-persons (person-mother an-ftree)))]))
;====================================================;
; FT -> Number
; produces the average age of all child structures in the family tree.

(check-expect (average-age NP 2022) 0)
(check-expect (average-age Carl 2022) 96)
(check-expect (average-age Adam 2022) 88)

(define (average-age ft yr)
  (cond
    [(no-person? ft) 0]
    [else (/ (+ (- yr (person-date ft))
                (average-age (person-father ft) yr)
                (average-age (person-mother ft) yr))
             (count-persons ft))]))
;====================================================;
; FT -> [List-of String]
; produces a list of all eye colors in the tree.

(check-expect (eye-colors NP) '())
(check-expect (eye-colors Carl) (list "green"))
(check-expect (eye-colors Adam) (list "hazel" "green" "green"))
(check-expect (eye-colors Gustav) (list "brown" "pink" "blue" "green" "green"))

(define (eye-colors ft)
  (cond
    [(no-person? ft) '()]
    [else (append (list (person-eyes ft))
                  (eye-colors (person-father ft))
                  (eye-colors (person-mother ft)))]))
;===================================================;
; FT -> Boolean
; does an-ftree father or mother contain a child
; structure with "blue" in the eyes field

(check-expect (blue-eyed-ancestor? NP) #false)
(check-expect (blue-eyed-ancestor? Eva) #false)
(check-expect (blue-eyed-ancestor? Gustav) #true)

(define (blue-eyed-ancestor? an-ftree)
  (cond
    [(no-person? an-ftree) #false]
    [else (or (blue-eyed-person? (person-father an-ftree))
              (blue-eyed-person? (person-mother an-ftree)))]))
