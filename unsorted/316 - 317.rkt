;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |316 - 317|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; An S-expr is one of: 
; – Atom
; – SL

; An SL is one of: 
; – '()
; – (cons S-expr SL)

; An Atom is one of: 
; – Number
; – String
; – Symbol 
;====================================================;
; Any -> Boolean

(check-expect (atom? 0) #true)
(check-expect (atom? "a") #true)
(check-expect (atom? 'a) #true)
(check-expect (atom? #true) #false)

(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))
;====================================================;
; S-expr Symbol -> N 
; counts all occurrences of sy in sexp

(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

(define (count sexp sy)
  (local (; SL Symbol -> N 
          ; counts all occurrences of sy in sl 
          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else (+ (count (first sl) sy) (count-sl (rest sl)))]))
          ; Atom Symbol -> N 
          ; counts all occurrences of sy in at 
          (define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)])))
    (cond
      [(atom? sexp) (count-atom sexp)]
      [else (count-sl sexp)])))
