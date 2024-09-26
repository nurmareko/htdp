;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |508|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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
              (make-editor (explode "") (explode "")))
(check-expect (split-structural (explode "hello") 0)
              (make-editor (explode "") (explode "hello")))
(check-expect (split-structural (explode "hello") 5)
              (make-editor (explode "") (explode "hello")))
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
              (make-editor (explode "hello") (explode "")))
(check-expect (split-structural (explode "hello") 100)
              (make-editor (explode "hello") (explode "")))

(define (split-structural ed x)
  (local (; [List-of 1String] -> [List-of 1String]
          ; get pre prefix of an Editor base on mouse x coordinate
          (define (get-prefix ed)
            (local ((define reversed-ed (reverse ed))
                    ; [List-of 1String] -> [List-of 1String]
                    (define (get-pre ed)
                      (cond
                        [(empty? ed) '()]
                        [else
                         (if (<= (image-width (editor-text ed)) x)
                             ed
                             (get-pre (rest ed)))])))
              (reverse (get-pre reversed-ed))))
          ; [List-of 1String] N -> [List-of 1String]
          ; remove the first n item from a list
          (define (get-suffix alist n)
            (cond
              [(zero? n) alist]
              [else
               (get-suffix (rest alist) (sub1 n))]))
          (define prefix (get-prefix ed))
          (define suffix (get-suffix ed (length prefix))))
    (make-editor prefix suffix)))