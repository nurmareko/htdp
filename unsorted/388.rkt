;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |388|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct employee [name sn pr])
(define-struct workrecord [name hours])
(define-struct paycheck [name wage])

; Employe is a structure
;  (make-employee String Number)
(define em01
  (make-employee "John" 1 5.65))
(define em02
  (make-employee "Lisa" 2 8.75))

; WordRecord is a structure
;  (make-workrecord String Number)
(define wr01
  (make-workrecord "John" 40))
(define wr02
  (make-workrecord "Lisa" 30))

; Paycheck is a structure
;  (make-paycheck String Number)
(define pc01
  (make-paycheck "John" 226.0))
(define pc02
  (make-paycheck "Lisa" 262.5))

; [List-of Employee] [List-of WordRecord] -> [List-of Paycheck]
; multiplies the corresponding items on 
; hours and wages/h 
; assume the two lists are of equal length

(check-expect (wages*.v2 '() '()) '())
(check-expect (wages*.v2 (list em01) (list wr01)) (list pc01))
(check-expect (wages*.v2 (list em01 em02) (list wr01 wr02)) (list pc01 pc02))

(define (wages*.v2 em wr)
  (map (lambda (a b) (weekly-wage a b)) em wr))

;(define (wages*.v2 em wr)
;  (cond
;    [(empty? wr) '()]
;    [else
;     (cons
;       (weekly-wage (first em) (first wr))
;       (wages*.v2 (rest em) (rest wr)))]))

; Employee WorkRecord -> Paycheck
; computes the weekly wage from pay-rate and hours
(define (weekly-wage em wr)
  (make-paycheck (employee-name em)
                 (* (employee-pr em) (workrecord-hours wr))))

