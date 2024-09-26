;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |509|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define FONT-SIZE 11)
(define FONT-COLOR "black")
(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))
 
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

(check-expect (split (explode "") 0)
              (make-editor '() '()))
(check-expect (split (explode "") 20)
              (make-editor '() '()))
(check-expect (split (explode "hello") 0)
              (make-editor '() (explode "hello")))
(check-expect (split (explode "hello") 5)
              (make-editor '() (explode "hello")))
(check-expect (split (explode "hello") 6)
              (make-editor (explode "h") (explode "ello")))
(check-expect (split (explode "hello") 11)
              (make-editor (explode "h") (explode "ello")))
(check-expect (split (explode "hello") 12)
              (make-editor (explode "eh") (explode "llo")))
(check-expect (split (explode "hello") 13)
              (make-editor (explode "eh") (explode "llo")))
(check-expect (split (explode "hello") 14)
              (make-editor (explode "leh") (explode "lo")))
(check-expect (split (explode "hello") 15)
              (make-editor (explode "leh") (explode "lo")))
(check-expect (split (explode "hello") 16)
              (make-editor (explode "lleh") (explode "o")))
(check-expect (split (explode "hello") 21)
              (make-editor (explode "lleh") (explode "o")))
(check-expect (split (explode "hello") 22)
              (make-editor (explode "olleh") '()))
(check-expect (split (explode "hello") 100)
              (make-editor (explode "olleh") '()))

(define (split ed0 x)
  (local (; [List-of 1String] [List-of 1String] -> Boolean
          (define (split-here? prefix suffix)
            (and (<= (image-width (editor-text prefix)) x)
                 (if (not (empty? suffix))
                     (< x (image-width (editor-text (cons (first suffix) prefix))))
                     #true)))
          ; [List-of 1String] [List-of 1String] -> Editor
          ; accumulator 'pre' is ... ed0 ... ed ...
          (define (split/a ed pre)
            (cond
              [(split-here? pre ed) (make-editor pre ed)]
              [else
               (split/a (rest ed) (cons (first ed) pre))])))
    (split/a ed0 '())))
;====================================================;
; String String -> Editor
; produces an Editor. The first string is the text
; to the left of the cursor and the second string is
; the text to the right of the cursor.
(define (create-editor left right)
  (make-editor (reverse (explode left))
               (explode right)))

; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
(define (editor-render ed)
  (place-image/align
    (beside (editor-text (reverse (editor-pre ed)))
            CURSOR
            (editor-text (editor-post ed)))
    1 1
    "left" "top"
    MT))
 
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(or (key=? k "\t") (key=? k "\r")) ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; Editor -> Editor
; move cursor one point to the left
; (if there any letter)
(define (editor-lft ed)
  (if
   (empty? (editor-pre ed))
   ed
   (make-editor (rest (editor-pre ed))
                (cons (first(editor-pre ed))
                      (editor-post ed)))))

; Editor -> Editor
; move cursor one point to the right
; (if there any letter)
(define (editor-rgt ed)
  (if
   (empty? (editor-post ed))
   ed
   (make-editor (cons (first (editor-post ed))
                      (editor-pre ed))
                (rest (editor-post ed)))))

; Editor -> Editor
; delete letter to the left of cursor
; (if there any letter)
(define (editor-del ed)
  (if
   (empty? (editor-pre ed))
   ed
   (make-editor (rest (editor-pre ed))
                (editor-post ed))))

; Editor 1String -> Editor
; insert the 1String k between pre and post
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

; Editor N N MouseEvent -> Editor
; ...
(define (move-cursor state x y me)
  (if (equal? me "button-down")
      (split (append (reverse (editor-pre state)) (editor-post state)) x)
      state))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [on-mouse move-cursor]
     [to-draw editor-render]))