;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |516|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct lam [par bod])
(define-struct app [fun arg])
; A Lam is one of:
; - Symbol
; - (make-λ Symbol Lam)
; - (make-app Lam Lam)
(define ex1 (make-lam 'x 'x))
(define ex2 (make-lam 'x 'y))
(define ex3 (make-lam 'y (make-lam 'x 'y)))
(define ex4 (make-app (make-lam 'x (make-app 'x 'x)) (make-lam 'x (make-app 'x 'x))))
(define ex515 (make-lam '*undeclared (make-app (make-lam 'x (make-app 'x '*undeclared)) 'y)))
;====================================================;
; Lam -> Lam
; replaces all symbols s in le with '*undeclared
; if they do not occur within the body of a λ 
; expression whose parameter is s

(check-expect (undeclareds ex1) (make-lam 'x '*declared:x))
(check-expect (undeclareds ex2) (make-lam 'x '*undeclared:y))
(check-expect (undeclareds ex3) (make-lam 'y (make-lam 'x '*declared:y)))

(define ex4-expected
  (make-app (make-lam 'x (make-app '*declared:x '*declared:x)) (make-lam 'x (make-app '*declared:x '*declared:x))))
(check-expect (undeclareds ex4) ex4-expected)

(define ex515-expected
  (make-lam '*undeclared (make-app (make-lam 'x (make-app '*declared:x '*declared:*undeclared)) '*undeclared:y)))
(check-expect (undeclareds ex515) ex515-expected)

(define (undeclareds le0)
  (local (; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (undeclareds/a le declareds)
            (cond
              [(symbol? le)
               (if (member? le declareds)
                   (string->symbol (string-append "*declared:" (symbol->string le)))
                   (string->symbol (string-append "*undeclared:" (symbol->string le))))]
              [(lam? le)
               (local ((define parameter (lam-par le))
                       (define body (lam-bod le))
                       (define newd (cons parameter declareds)))
                 (make-lam  parameter (undeclareds/a body newd)))]
              [(app? le)
               (make-app (undeclareds/a (app-fun le) declareds)
                         (undeclareds/a (app-arg le) declareds))])))
    (undeclareds/a le0 '())))