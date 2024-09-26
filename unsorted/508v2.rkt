;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 508v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define FONT-SIZE 11)
(define FONT-COLOR "black")
 
; [List-of 1String] -> Image
; renders a string as an image for the editor 
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))
 
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor [List-of 1String] [List-of 1String])
; interpretation if (make-editor p s) is the state of 
; an interactive editor, (reverse p) corresponds to
; the text to the left of the cursor and s to the
; text on the right
;====================================================;
; [List-of 1String] N -> Editor
; produces (make-editor p s)
; such that:
; (1) p and s make up ed
; (2) x is larger than the image of p and smaller
; than the image of p extended with the first 1String
; on s (if any).

(check-expect (split-structural (explode "") 0)
              (make-editor '() '()))
(check-expect (split-structural (explode "") 20)
              (make-editor '() '()))
(check-expect (split-structural (explode "hello") 0)
              (make-editor '() (explode "hello")))
(check-expect (split-structural (explode "hello") 5)
              (make-editor '() (explode "hello")))
(check-expect (split-structural (explode "hello") 6)
              (make-editor (explode "h") (explode "ello")))
(check-expect (split-structural (explode "hello") 11)
              (make-editor (explode "h") (explode "ello")))
(check-expect (split-structural (explode "hello") 12)
              (make-editor (explode "he") (explode "llo")))
(check-expect (split-structural (explode "hello") 13)
              (make-editor (explode "he") (explode "llo")))
(check-expect (split-structural (explode "hello") 14)
              (make-editor (explode "hel") (explode "lo")))
(check-expect (split-structural (explode "hello") 15)
              (make-editor (explode "hel") (explode "lo")))
(check-expect (split-structural (explode "hello") 16)
              (make-editor (explode "hell") (explode "o")))
(check-expect (split-structural (explode "hello") 21)
              (make-editor (explode "hell") (explode "o")))
(check-expect (split-structural (explode "hello") 22)
              (make-editor (explode "hello") '()))
(check-expect (split-structural (explode "hello") 100)
              (make-editor (explode "hello") '()))

(define (split-structural ed x)
  (local (; [List-of 1String] N -> [List-of 1Sting]
          ; get the correct suffix base on x.
          (define (get-suffix ed x)
            (cond
              [(empty? ed) '()]
              [else
               (local ((define 1s-list (list (first ed)))
                       (define 1s-image (editor-text 1s-list))
                       (define 1s-width (image-width 1s-image)))
                 (if (< x 1s-width)
                     ed
                     (get-suffix (rest ed) (- x 1s-width))))]))
          ; [List-of X] N -> [List-of X]
          ; remove the last n item on a list
          (define (remove-last n alist)
            (local ((define reversed (reverse alist))
                    ; [List-of X] N -> [List-of X]
                    (define (remove-last n alist)
                      (cond
                        [(zero? n) alist]
                        [else (remove-last (sub1 n) (rest alist))])))
              (reverse (remove-last n reversed))))
          (define suffix (get-suffix ed x))
          (define prefix (remove-last (length suffix) ed)))
    (make-editor prefix suffix)))

;; [List-of 1String] N -> [List-of 1Sting]
;; get the correct suffix base on x.
;
;(check-expect (get-suffix (explode "") 0)  '())
;(check-expect (get-suffix (explode "") 20) '())
;(check-expect (get-suffix (explode "hello") 0) (explode "hello"))
;(check-expect (get-suffix (explode "hello") 5) (explode "hello"))
;(check-expect (get-suffix (explode "hello") 6)  (explode "ello"))
;(check-expect (get-suffix (explode "hello") 11) (explode "ello"))
;(check-expect (get-suffix (explode "hello") 12) (explode "llo"))
;(check-expect (get-suffix (explode "hello") 13) (explode "llo"))
;(check-expect (get-suffix (explode "hello") 14) (explode "lo"))
;(check-expect (get-suffix (explode "hello") 15) (explode "lo"))
;(check-expect (get-suffix (explode "hello") 16) (list "o"))
;(check-expect (get-suffix (explode "hello") 21) (list "o"))
;(check-expect (get-suffix (explode "hello") 22) '())
;(check-expect (get-suffix (explode "hello") 99) '())
;
;(define (get-suffix ed x)
;  (cond
;    [(empty? ed) '()]
;    [else
;     (local ((define 1s-list (list (first ed)))
;             (define 1s-image (editor-text 1s-list))
;             (define 1s-width (image-width 1s-image)))
;       (if (< x 1s-width)
;           ed
;           (get-suffix (rest ed) (- x 1s-width))))]))
;
;; [List-of X] N -> [List-of X]
;; remove the last n item on a list
;
;(check-expect (remove-last 0 (explode "hello")) (explode "hello"))
;(check-expect (remove-last 1 (explode "hello")) (explode "hell"))
;(check-expect (remove-last 2 (explode "hello")) (explode "hel"))
;(check-expect (remove-last 3 (explode "hello")) (explode "he"))
;(check-expect (remove-last 4 (explode "hello")) (list "h"))
;(check-expect (remove-last 5 (explode "hello")) '())
;
;(define (remove-last n alist)
;  (local ((define reversed (reverse alist))
;          ; [List-of X] N -> [List-of X]
;          (define (remove-last n alist)
;            (cond
;              [(zero? n) alist]
;              [else (remove-last (sub1 n) (rest alist))])))
;    (reverse (remove-last n reversed))))