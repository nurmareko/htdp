;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |257|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [X] Number [N -> X] -> [List-of X]

(check-expect (pseu-build-list 3 +)
              (build-list 3 +))

(define (pseu-build-list n F)
  (cond [(= n 0) '()]
        [else (add-at-end (F (sub1 n))
                    (pseu-build-list (sub1 n) F))]))

; [X] X [List-of X] -> [List-of X]

(check-expect
 (add-at-end "right" (list "left" "middle"))
 (list "left" "middle" "right"))

(define (add-at-end x lx)
  (append lx (list x)))
