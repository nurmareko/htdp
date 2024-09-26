;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |305|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; 0.94€ per US$ equal to US$1.06 per €
(define RATE 0.94)

; [List-of Number] -> [List-of Number]
; converts a list of US$ amounts into a list of €
; amounts based on an exchange rate of US$1.06 per €

(check-expect (us2eu.v2 (list 1 5 12))
              (list (* 1 RATE)
                    (* 5 RATE)
                    (* 12 RATE)))

(define (us2eu.v2 ln)
  (for/list ([l ln]) (* RATE l)))