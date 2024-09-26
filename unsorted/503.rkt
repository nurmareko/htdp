;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |503|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Matrix -> Matrix 
; finds a row that doesn't start with 0 and
; uses it as the first one
; generative moves the first row to last place 
; no termination if all rows start with 0

(check-expect (rotate '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(check-error (rotate '((0 4 5) (0 2 3))))

(define (rotate M)
  (local ((define all-start-with-zero?
            (andmap (lambda (r) (zero? (first r))) M))
          ; Matrix -> Matrix
          (define (rotate M)
            (cond
              [(not (= (first (first M)) 0)) M]
              [else
               (rotate (append (rest M) (list (first M))))])))
    (if all-start-with-zero?
        (error "all start with zero")
        (rotate M))))
;====================================================;
; Matrix -> Matrix
; finds a row that doesn't start with 0 and
; uses it as the first one
; generative moves the first row to last place 
; no termination if all rows start with 0

(check-expect (rotate.v2 '((1 2 3) (0 4 5)))
              '((1 2 3) (0 4 5)))
(check-expect (rotate.v2 '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(check-error (rotate.v2 '((0 4 5) (0 2 3))))

(define (rotate.v2 M0)
  (local (; Matrix [List-of Row] -> Matrix
          ; finds a row that doesn't start with 0 and
          ; uses it as the first one
          ; accumulator 'seen' is the list of row
          ; that start with 0 that M lack from M0
          (define (rotate/a M seen)
            (cond
              [(empty? M) (error "all row start with 0")]
              [(not (= (first (first M)) 0)) (append M seen)]
              [else (rotate/a (rest M)
                              (cons (first M) seen))])))
    (rotate/a M0 '())))
