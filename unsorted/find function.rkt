;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |find function|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct lc [letter count])

; [X] [X -> Boolean] [NEList-of X] -> X
; find the (first) element of the list for which
; p holds, if nothing is found return error message
(define (find p lx)
  (cond [(empty? lx) (error "NF.")]
        [else (if (p (first lx))
                  (first lx)
                  (find p (rest lx)))]))


; [List-of Number] -> Number

(check-expect (find-9 (list 1 2 4 9 7)) 9)
(check-error (find-9 (list 1 2 4 7)))

(define (find-9 ln)
  (local [(define (9? x)
          (equal? x 9))]
  (find 9? ln)))

;[List-of Letter-Counts] -> Letter-Counts

(check-expect
 (find-b (list (make-lc "a" 55) (make-lc "b" 13)))
 (make-lc "b" 13))

(define (find-b l-lc)
  (local [(define (b? lc)
            (equal? "b" (lc-letter lc)))]
  (find b? l-lc)))
              
(argmax lc-count (list (make-lc "a" 55) (make-lc "b" 13)))

