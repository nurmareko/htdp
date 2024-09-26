;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |502|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [NEList-of 1String] -> [NEList-of 1String]
; creates a palindrome from s0

(check-expect
 (mirror (explode "abc")) (explode "abcba"))

(define (mirror s0)
  (append (all-but-last s0)
          (list (last s0))
          (reverse (all-but-last s0))))

; [NEList-of X] -> X
; extracts the last item from a non-empty list

(check-error (last '()))
(check-expect (last '(a)) 'a)
(check-expect (last '(a b)) 'b)

(define (last alox)
  (cond
    [(empty? (rest alox)) (first alox)]
    [else (last (rest alox))]))

; [NEList-of X] -> [NElist-of X]
; keep all but last item from a non-empty list

(check-error (all-but-last '()))
(check-expect (all-but-last '(a)) '())
(check-expect (all-but-last '(a b c)) '(a b))

(define (all-but-last alox)
  (cond
    [(empty? (rest alox)) '()]
    [else
     (cons (first alox)
           (all-but-last (rest alox)))]))
;====================================================;
; [NEList-of 1String] -> [NEList-of 1String]
; creates a palindrome from s0

(check-expect
  (mirror.v2 (explode "abc")) (explode "abcba"))

(define (mirror.v2 s0)
  (local (; [NEList-of 1String] [List-of 1String]-> [NEList-of 1String]
          ; creates a palindrome from s0
          ; accumulator 'a' is the list of item that
          ; s lacks from s0, in reverse order
          (define (mirror/a s a)
            (cond
              [(empty? (rest s)) (append s0 a)]
              [else
               (mirror/a (rest s) (cons (first s) a))])))
    (mirror/a s0 '())))
