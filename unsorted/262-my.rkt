;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 262-my) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; A Row is a [List-of Number]

; Number -> [List-of Row]
; creates diagonal squares of 0s and 1s
(define (identityM n)
  (local (; Number -> Row
          ; build a row of 0s and 1s of x length
          (define (build-row x)
            (local (; Number -> Number
                    ; determine 0s and 1s position
                    (define (one-at-x za)
                      (if (= za x) 1 0)))
              ; - IN -
              (build-list n one-at-x))))
    ; - IN -
    (build-list n build-row)))

; functional tests
;(check-expect (identityM 0) '())
;(check-expect (identityM 1) (list
;                             (list 1)))
;(check-expect (identityM 2) (list
;                             (list 1 0)
;                             (list 0 1)))
(check-expect (identityM 3) (list
                             (list 1 0 0)
                             (list 0 1 0)
                             (list 0 0 1)))
;(check-expect (build-row 0 3) (list 1 0 0))
;(check-expect (build-row 1 3) (list 0 1 0))
;(check-expect (build-row 2 3) (list 0 0 1))