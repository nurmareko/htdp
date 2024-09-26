;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise82) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; AorF is one of one-letter lowercase alphabet or #false:
; - "a"
; - ...
; - "z"
; - #false

; A Word3l is a structure:
;     (make-word3l AorF AorF AorF)
; interpretation a word consists of tree lowercase alphabet or #false

; examples:
; (make-word3l "c" "a" "t")
; (make-word3l "d" "o" #false)
; (make-word3l #false #false #false)

(define-struct word3l [1st 2nd 3rd])

(check-expect (comp-wrd (make-word3l "d" "o" "g") (make-word3l "d" "o" "g")) #t)
(check-expect (comp-wrd (make-word3l "d" "o" "g") (make-word3l #f #f #f)) #t)
(check-expect (comp-wrd (make-word3l "d" "o" #f) (make-word3l "d" "o" "g")) #t)
(check-expect (comp-wrd (make-word3l "d" "o" "g") 0) #f)

; Word3l Word3l -> Boolean
; compare if the given word are same structure type
; if yes give #true else #false
(define (comp-wrd a b)
  (and (word3l? a) (word3l? b)))

(check-expect (comp-lett (make-word3l "d" "o" "g") (make-word3l "d" "o" "g")) #t)
(check-expect (comp-lett (make-word3l "d" "o" "g") (make-word3l "f" "o" "g")) #f)
(check-expect (comp-lett (make-word3l "d" "o" "g") (make-word3l #f #f #f)) #f)
(check-expect (comp-lett (make-word3l #f "o" "g") (make-word3l #f "o" "g")) #t)

; Word3l Word3l -> Boolean
; compare each letter inside word if equal give #true else #false
(define (comp-lett a b)
  (and (equal? (word3l-1st a) (word3l-1st b))
       (equal? (word3l-2nd a) (word3l-2nd b))
       (equal? (word3l-3rd a) (word3l-3rd b))))

(check-expect (comp-wnl (make-word3l "d" "o" "g") (make-word3l "d" "o" "g")) (make-word3l "d" "o" "g"))
(check-expect (comp-wnl (make-word3l "d" "o" "g") (make-word3l "c" "a" "t")) #f)

; Word3l Word3l -> Word3l/#f
; compare both word and letter if equal give Word3l else #f
(define (comp-wnl a b)
  (if (and (comp-lett a b) (comp-wrd a b)) a #f))