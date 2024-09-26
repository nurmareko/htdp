;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |389|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone-record [name number])
; A PhoneRecord is a structure:
;   (make-phone-record String String)
;====================================================;
; [List-of String] [List-of String] -> [List-of PhoneRecord]

(check-expect (zip '() '()) '())
(check-expect (zip '("Azusa") '("082110778883"))
              (list (make-phone-record "Azusa" "082110778883")))
(check-expect (zip '("Azusa" "Mio") '("082110778883" "083994770002"))
              (list (make-phone-record "Azusa" "082110778883")
                    (make-phone-record "Mio" "083994770002")))

(define (zip names nums)
  (map (lambda (a b) (make-phone-record a b)) names nums))

;(define (zip names nums)
;  (cond
;    [(empty? names) '()]
;    [else
;     (cons
;      (make-phone-record (first names) (first nums))
;      (zip (rest names) (rest nums)))]))