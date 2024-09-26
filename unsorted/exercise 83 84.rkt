;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 83 84|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define TXT-SZ 16)
(define TXT-CL "black")
(define CRSR (rectangle 1 20 "solid" "red"))
(define BG (empty-scene 200 20))

; Editor -> Image
; display entire text and cursor
(define (render x)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre x) TXT-SZ TXT-CL)
                  CRSR
                  (text (editor-post x) TXT-SZ TXT-CL))
                 BG))

; Editor KeyEvent -> Editor
; move cursor position on text, delete or  add character to text base on keystroke
; if keystroke are "\t" or "\r" ignore
; if keystroke are \b delete ed pre field last character
; if keystroke are "left or "right" move the cursor position
; the rest of keystroke will be added to the front of cursor

(check-expect (edit (make-editor "spag" "hetti") "k") (make-editor "spagk" "hetti"))
(check-expect (edit (make-editor "spag" "hetti") "\b") (make-editor "spa" "hetti"))
(check-expect (edit (make-editor "spag" "hetti") "\t") (make-editor "spag" "hetti"))
(check-expect (edit (make-editor "spag" "hetti") "\r") (make-editor "spag" "hetti"))
(check-expect (edit (make-editor "spag" "hetti") "left") (make-editor "spa" "ghetti"))
(check-expect (edit (make-editor "spag" "hetti") "right") (make-editor "spagh" "etti"))

(define (edit ed ke)
  (cond
    [(string=? ke "left")
     (if (= (string-length (editor-pre ed)) 0)
         ed
         (make-editor (string-remove-last (editor-pre ed)) (string-append (string-last (editor-pre ed)) (editor-post ed))))]
    [(string=? ke "right")
     (if (= (string-length (editor-post ed)) 0)
         ed
         (make-editor (string-append (editor-pre ed) (string-first (editor-post ed))) (string-rest (editor-post ed))))]
    [(or (string=? ke "\t") (string=? ke "\r"))
     ed]
    [(string=? ke "\b")
     (if (= (string-length (editor-pre ed)) 0)
         ed
         (make-editor (substring (editor-pre ed) 0 (- (string-length (editor-pre ed)) 1)) (editor-post ed)))]
    [else
     (if (>= (image-width (beside
                          (text (editor-pre ed) TXT-SZ TXT-CL)
                          CRSR
                          (text (editor-post ed) TXT-SZ TXT-CL)))
            (- (image-width BG) 10))
         ed
         (make-editor (string-append (editor-pre ed) ke) (editor-post ed)))]))

; auxiliary functions 
(define (string-first s)
  (string-ith s 0))

(define (string-last s)
  (string-ith s (- (string-length s) 1)))

(define (string-rest s)
 	(substring s 1)) 

(define (string-remove-last s)
	(substring s 0 (- (string-length s) 1)))

(define test(make-editor "spag" "hetti"))

(define (run x)
  (big-bang x
    [to-draw render]
    [on-key edit]))