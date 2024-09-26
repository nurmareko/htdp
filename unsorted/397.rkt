;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |397|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct ER [name id pay-rate])
(define-struct TR [name hours])
(define-struct WR [name weekly-wage])

; an Employee is a structure
;  (make-ER String Number Number)

; a TimeCard is a structure
;  (make-TR String Number)

; a Paycheque is a structure
;  (make-WR String Number)

;====================================================;
(define date
  (make-ER "Date Kaname" 01 20))
(define ryuki
  (make-ER "Kuruto Ryuki" 02 15))
(define mizuki
  (make-ER "Date Mizuki" 03 10))

(define date-tc
  (make-TR "Date Kaname" 16))
(define ryuki-tc
  (make-TR "Kuruto Ryuki" 54))
(define mizuki-tc
  (make-TR "Date Mizuki" 72))

(define date-wr
  (make-WR "Date Kaname" 320))
(define ryuki-wr
  (make-WR "Kuruto Ryuki" 810))
(define mizuki-wr
  (make-WR "Date Mizuki" 720))
;====================================================;
; [List-of Employee] [List-of TimeCard] -> [List-of Paycheque]
; produces a list of wage records, The function
; signals an error if it cannot find an employee
; record for a time card or vice versa.

(check-expect (wage*.v3 '() '()) '())
(check-expect
 (wage*.v3 `(,date ,ryuki ,mizuki) `(,date-tc ,ryuki-tc ,mizuki-tc))
 `(,date-wr ,ryuki-wr ,mizuki-wr))
(check-expect
 (wage*.v3 `(,date ,ryuki ,mizuki) `(,ryuki-tc ,mizuki-tc ,date-tc))
 `(,ryuki-wr ,mizuki-wr ,date-wr))
(check-error (wage*.v3 `(,date) `(,ryuki-tc ,mizuki-tc)) "not found")
(check-error (wage*.v3 `(,ryuki ,mizuki) `(,date-tc)) "not found")

;(define (wage*.v3 em tc)
;  (cond
;    {(empty? tc) '()}
;    [else
;     (local ((define card (first tc))
;             (define employee (find (TR-name card) em)))
;       (cons (weekly-wage employee card)
;             (wage*.v3 em (rest tc))))]))

(define (wage*.v3 em tc)
  (map (lambda (c) (weekly-wage (find (TR-name c) em) c)) tc))
;====================================================;
; Employee TimeCard -> Paycheque
; computes the weekly wage from pay-rate and hours

(check-expect (weekly-wage date date-tc) date-wr)

(define (weekly-wage em tc)
  (make-WR (ER-name em) (* (ER-pay-rate em) (TR-hours tc))))
;====================================================;
; String [List-of Employee] -> Employee
; find employee with given name

(check-expect (find "Date Mizuki" `(,date ,ryuki ,mizuki)) mizuki)
(check-error (find "Aiba" `(,date ,ryuki ,mizuki)))

;(define (find name le)
;  (cond
;    [(empty? le) (error "not found")]
;    [else
;     (if (string=? name (ER-name (first le)))
;         (first le)
;         (find name (rest le)))]))

(define (find name le)
  (local ((define picked (filter (lambda (e) (string=? name (ER-name e))) le)))
  (if (empty? picked) (error "not found") (first picked))))


