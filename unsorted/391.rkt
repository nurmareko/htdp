;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |391|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; replaces the final '() in front with end

(check-expect (replace-eol-with '() '()) '())
(check-expect (replace-eol-with '() '(2)) '(2))
(check-expect (replace-eol-with '(1) '()) '(1))
(check-expect (replace-eol-with '(1) '(2)) '(1 2))
(check-expect (replace-eol-with '(1 2) '(3 4)) '(1 2 3 4))

(define (replace-eol-with front end)
  (cond
    [(empty? front) end]
    [else
     (cons (first front)
           (replace-eol-with (rest front) end))]))

;(define (replace-eol-with front end)
;  (foldr (lambda (a b) (cons a b)) end front))

;(define (replace-eol-with front end)
;  (cond
;    [(and (empty? front) (empty? end)) '()]
;    [(empty? front) end]
;    [(empty? end) front]
;    [else
;     (cons (first front) 
;           (replace-eol-with (rest front) end))]))

;(define (replace-eol-with front end)
;  (cond
;    [(and (empty? front) (empty? end))
;     '()]
;    [(and (empty? front) (cons? end))
;     end]
;    [(and (cons? front) (empty? end))
;     front]
;    [(and (cons? front) (cons? end))
;     (cons (first front) 
;           (replace-eol-with (rest front) end))]))

; A
;(replace-eol-with (rest front) (rest end))
;(replace-eol-with '() '())
; = '()
; B
;(replace-eol-with (rest front) end)
;(replace-eol-with '() '(2))
; = '(2)
; C
;(replace-eol-with front (rest end))
;(replace-eol-with '(1) '())
; = '(1)

;(define (replace-eol-with front end)
;  (cond
;    [(and (empty? front) (empty? end))
;     ...]
;    [(and (empty? front) (cons? end))
;     (... (first end) ... (rest end) ...)]
;    [(and (cons? front) (empty? end))
;     (... (first front) ... (rest front) ...)]
;    [(and (cons? front) (cons? end))
;     (... (first front) ... (rest front) ...
;      ... (first end) ... (rest end) ...)]))