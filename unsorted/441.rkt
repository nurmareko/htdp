;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |441|) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers (rest alon) pivot))
                    (list pivot)
                    (quick-sort< (largers (rest alon) pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))
 
; [List-of Number] Number -> [List-of Number]
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (<= (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))
;====================================================;
;(quick-sort< (list 10 6 8 9 14 12 3 11 14 16 2))

;(append (append (append (append '() ; + 1
;                                '(2)
;                                '()) ; + 1 1
;                        '(3)
;                        '()) ; + 1 1
;                '(6)
;                (append '() ; + 1
;                        '(8)
;                        (append '() ; + 1
;                                '(9)
;                                '()))) ; + 1 1 1 1
;        '(10)
;        (append (append (append '() ; + 1
;                                '(11)
;                                '()) ; + 1 1
;                        '(12)
;                        (append '() ; + 1
;                                '(14)
;                                '())) ; + 1 1 1
;                '(14)
;                (append '() ; + 1
;                        '(16)
;                        '()))) ; + 1 1 1

; for every non-trivial case there will be two
; recursive call and one application of append,
; therefore for a list of length n there will be
; (n * 2) recursive calls, and (n * 1) append
; applications.

; > (length (list 10 6 8 9 14 12 3 11 14 16 2))
; 11

; recursive = (11 * 2) = 22
; append    = (11 * 1) = 11
;====================================================;
; (quick-sort< (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))

;(append '() ; + 1
;        '(1)
; (append '() ; + 1
;         '(2)
;  (append '() ; + 1
;          '(3)
;   (append '() ; + 1
;           '(4)
;    (append '() ; + 1
;            '(5)
;     (append '() ; + 1
;             '(6)
;      (append '() ; + 1
;              '(7)
;       (append '() ; + 1
;               '(8)
;        (append '() ; + 1
;                '(9)
;         (append '() ; + 1
;                 '(10)
;          (append '() ; + 1
;                  '(11)
;           (append '() ; + 1
;                   '(12)
;            (append '() ; + 1
;                    '(13)
;             (append '() ; + 1
;                     '(14)
;                     '())))))))))))))) ; + 1 1 1 1 1 1 1 1 1 1 1 1 1 1

; > (length (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))
; 14

; recursive = (14 * 2) = 28
; append    = (14 * 1) = 14
;===================================================;
; does this contradict the first part of the exercise?

; no, the general rule still apply.