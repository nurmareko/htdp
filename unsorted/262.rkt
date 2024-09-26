;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |262|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> [List-of [List-of Number]]

(check-expect (identityM 0) '())
(check-expect (identityM 1) (list (list 1)))
(check-expect(identityM 2)
             (list (list 1 0) (list 0 1)))
(check-expect (identityM 3)
              (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))

(define (identityM n)
  (local [; Number -> [List-of Number]
          (define (diagonalize x)
            (local [; Number -> Number
                    (define (helper r)
                      (if (= x r) 1 0))]
              ; - IN -
              (build-list n helper)))]
    ;- IN -
    (build-list n diagonalize)))
