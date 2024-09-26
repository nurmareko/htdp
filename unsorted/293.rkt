;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |293|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [X] X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise

(check-satisfied (find 0 '()) (found? 0 '()))
(check-satisfied (find 0 '(1 1 1)) (found? 0 '(1 1 1)))
(check-satisfied (find 0 '(0 1 1)) (found? 0 '(0 1 1)))
(check-satisfied (find 0 '(1 0 1)) (found? 0 '(1 0 1)))
(check-satisfied (find 0 '(1 1 0)) (found? 0 '(1 1 0)))
(check-satisfied (find 0 '(0 0 0)) (found? 0 '(0 0 0)))

(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))
;====================================================;
; [X] X [List-of X] -> [[X] [Maybe [List-of X] -> Boolean]
; specification of a find function
; confirm that result is the correct answer

;result must be #false or non-empty list of X
(check-expect [(found? 0 '()) 0] #false)
(check-expect [(found? 0 '()) #true] #false)
(check-expect [(found? 0 '(0)) '()] #false)
;if result is #false, confirm that X is not appear in lx
(check-expect [(found? 0 '()) #false] #true)
(check-expect [(found? 0 '(1 1 1)) #false] #true)
(check-expect [(found? 0 '(1 0 1)) #false] #false)
;if result is non-empty list of x. confirm that result is a sublist of lx
(check-expect [(found? 0 '(0)) '(0)] #true)
(check-expect [(found? 0 '(1 0 1 1)) '(0 1 1)] #true)
(check-expect [(found? 0 '(1 0 1 0 0)) '(0 1 0 0)] #true)
(check-expect [(found? 0 '(1 0 1 1)) '(0 1 1 1)] #false)
(check-expect [(found? 0 '(1 0 1 1)) '(0 1)] #false)
(check-expect [(found? 0 '(1 0 1 1)) '(0)] #false)
(check-expect [(found? 0 '(1 0 1 0 0)) '(0 0)] #false)

(define (found? x lx)
  (lambda (result)
    (local [(define empty?/not-member?
              (or (empty? lx) (not (member? x lx))))
            
            (define nelist?-1st=?
              (and (list? result)
                   (not (empty? result))
                   (equal? x (first result))))]
      ; - IN -
      (cond 
        [(false? result) empty?/not-member?]
        [nelist?-1st=? (sublist? result lx)]
        [else #false]))))
;====================================================;
; [X] [NEList-of X] [NEList-of X] -> Boolean
; is l-a sublist of l-b?

;confirm that l-a is a subilst of l-b
(check-expect (sublist? '(0) '(0)) #true)
(check-expect (sublist? '(0) '(1 0)) #true)
(check-expect (sublist? '(0 0) '(1 0 0)) #true)
(check-expect (sublist? '(0) '(1)) #false)
(check-expect (sublist? '(0) '(0 1)) #false)
(check-expect (sublist? '(1 0) '(1 0 0)) #false)

(define (sublist? l-a l-b)
  (and (<= (length l-a) (length l-b))
       (if (equal? (first l-a) (first l-b))
           (equal? l-b l-a)
           (sublist? l-a (rest l-b)))))