;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |16.5 close funtion|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Posn] Posn -> Boolean
; is any Posn on lop close to pt
 
(check-expect
 (close? (list (make-posn 47 54) (make-posn 0 60))
         (make-posn 50 50))
 #true)
 
(define (close? lop pt)
  (local (; Posn -> Boolean
          ; is one shot close to pt
          (define (is-one-close? p)
            (close-to p pt CLOSENESS)))
    (ormap is-one-close? lop)))
 
(define CLOSENESS 5) ; in terms of pixels 

;====================================================;
; Posn Posn Number -> Boolean
; is the distance between p and q less than d

(check-expect
 (close-to (make-posn 10 10) (make-posn 16 16) 5)
 #false)
(check-expect
 (close-to (make-posn 10 10) (make-posn 15 16) 5)
 #true)        

(define (close-to p q d)
  (or (<= (abs (- (posn-x p) (posn-x q))) 5)
      (<= (abs (- (posn-y p) (posn-y q))) 5)))