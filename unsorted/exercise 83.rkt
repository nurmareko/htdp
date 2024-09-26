;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 83|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define TXT-SZ 16)
(define TXT-CL "black")
(define CRSR (rectangle 1 20 "solid" "red"))
(define BG (empty-scene 200 20))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; Editor -> Image
; display entire text

(define (render x)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre x) TXT-SZ TXT-CL)
                  CRSR
                  (text (editor-post x) TXT-SZ TXT-CL))
                 BG))

(check-expect (edit (make-editor "spag" "hetti") "k") (make-editor "spagk" "hetti"))
(check-expect (edit (make-editor "spag" "hetti") "\b") (make-editor "spa" "hetti"))
(check-expect (edit (make-editor "spag" "hetti") "\t") (make-editor "spag" "hetti"))
(check-expect (edit (make-editor "spag" "hetti") "\r") (make-editor "spag" "hetti"))

(define (edit ed ke)
  (cond
    [(or (string=? ke "\t") (string=? ke "\r"))
     ed]
    [(string=? ke "\b")
     (make-editor (substring (editor-pre ed) 0 (- (string-length (editor-pre ed)) 1)) (editor-post ed))]
    [else
     (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]))
                 