;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |451 new|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct table [length array])
; A Table is a structure:
;   (make-table N [N -> Number])

(define table1 (make-table 3 (lambda (i) i)))
 
; N -> Number
(define (a2 i)
  (if (= i 0)
      pi
      (error "table2 is not defined for i =!= 0")))
 
(define table2 (make-table 1 a2))

(define table3 (make-table 1024 (lambda (i) (+ 0 (- i 1023)))))

; Table N -> Number
; looks up the ith value in array of t
(define (table-ref t i)
  ((table-array t) i))
;====================================================;
; Table -> N
; finds the smallest index for a root of the
; monotonically increasing table.

;(check-expect (find-linear table1) 0)
;(check-error (find-linear table2))
;(check-expect (find-linear table3) 1023) ; 13318 steps

(define (find-linear t)
  (local ((define length (table-length t))
          (define array (table-array t))
          ; N -> N
          (define (find n)
            (cond
              [(zero? (array n)) n]
              [else
               (if (= length n)
                   (error "root not found")
                   (find (add1 n)))])))
    (find 0)))
;====================================================;
; Table -> N
; finds the smallest index for a root of the
; monotonically increasing table.
; termination:
; because the algorihm check the newly generated problems for
; some condition such (<= f@l 0 @mid) or (find mid @mid r @r),
; when both of those condition are not satisfied the algorihm
; signal an error message therefore the algorihm will eventually
; terminated.

(check-expect (find-binary table1) 0)
;(check-error (find-binary table2))
(check-expect (find-binary table3) 1023) ; 256 steps

(define (find-binary t)
  (local ((define length (table-length t))
          (define array (table-array t))
          ; [N -> N] N N -> N     
          (define (find-generative l r)
            (local ((define (find l @l r @r)
                      (cond
                        [(zero? @l) l]
                        [(zero? @r) r]
                        [else
                         (local ((define mid (/ (+ l r) 2))
                                 (define @mid (array mid)))
                           (cond
                             [(<= @l 0 @mid)
                              (find l @l mid @mid)]
                             [(<= @mid 0 @r)
                              (find mid @mid r @r)]
                             [else
                              (error "root not found")]))])))
              (find l (array l) r (array r)))))
    (find-generative 0 length)))
    

    
