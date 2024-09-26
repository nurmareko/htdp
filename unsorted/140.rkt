;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |140|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct layer [stuff])

; An LStr is one of: 
; – String
; – (make-layer LStr)
(define lstr-1
  "the")
(define lstr-2
  (make-layer "the"))
(define lstr-3
  (make-layer (make-layer "the")))
	
; An LNum is one of: 
; – Number
; – (make-layer LNum)
(define lnum-1
  12)
(define lnum-2
  (make-layer 12))
(define lnum-3
  (make-layer (make-layer 12)))
