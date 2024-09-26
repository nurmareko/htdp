;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |267|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; 0.94€ per US$ equal to US$1.06 per €
(define RATE 0.94)

; [List-of Number] -> [List-of Number]
; converts a list of US$ amounts into a list of €
; amounts based on an exchange rate of US$1.06 per €

(check-expect (us2eu (list 1 5 12))
              (list (* 1 RATE)
                    (* 5 RATE)
                    (* 12 RATE)))

(define (us2eu ln)
  (local [; Number -> Number
          (define (convert n)
            (* n RATE))]
    ; - IN -
    (map convert ln)))
;====================================================;
; [List-of Number] -> [List-of Number]
; converts a list of Fahrenheit measurements to a
; list of Celsius measurements.

(check-expect (convertFC (list 32 60.8 86))
              (list 0 16 30))

(define (convertFC ln)
  (local [; Number -> Number
          (define (convert n)
            (* (- n 32) 5/9))]
    ; - IN -
    (map convert ln)))
;====================================================;
; Pair is (list Number Number)

; [List-of Posn] -> [List-of Pair]
; translates a list of Posns into a list of lists of
; pairs of numbers.

(check-expect (translate (list (make-posn 10 10)
                               (make-posn 14 33)))
                         (list (list 10 10)
                               (list 14 33)))

(define (translate l-ps)
  (local [; Posn -> Pair
          (define (convert v)
            (list (posn-x v) (posn-y v)))]
    ; - IN -
    (map convert l-ps)))