;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |308|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone [area switch four])
; Phone is a structure
;   (make-phone Number Number Number)
;====================================================;
; [List-of Phone] -> [List-of Phone]

(check-expect (replace '()) '())

(define input1 (list (make-phone 713 664 9993)))
(define expect1 (list (make-phone 281 664 9993)))
(check-expect (replace input1) expect1)

(define input2 (list (make-phone 777 664 9993)))
(define expect2 (list (make-phone 777 664 9993)))
(check-expect (replace input2) expect2)

(define input3 (list (make-phone 713 664 9993)
                     (make-phone 777 226 9888)
                     (make-phone 713 233 6673)))
(define expect3 (list (make-phone 281 664 9993)
                      (make-phone 777 226 9888)
                      (make-phone 281 233 6673)))
(check-expect (replace input3) expect3)

(define (replace lp)
  (for/list ([p lp])
    (match p
      [(phone 713 s f) (make-phone 281 s f)]
      [p p])))