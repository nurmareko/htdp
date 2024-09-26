;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |363 364 365 366 367|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An Xexpr.v2 is:
;  (cons Symbol Body)

; A Body is one of:
; - empty
; - [List-of Xexpr.v2]
; - (cons [List-of Attribute] [List-of Xexpr.v2])

; An Attribute is:
;  (list Symbol String)

; An [Or X Y] is one of:
; - X
; - Y

; An AttrsOrXexpr is
;  [Or [List-of Attribute] Xexpr.v2]
;=364================================================;
;'(transition ((from "seen-e") (to "seen-f")))
;'(ul (li (word) (word)) (li (word)))
;=365================================================;
;'(server ((name "example.org")))
;<server name="example.org" />
;'(carcas (board (grass)) (player ((name "sam"))))
;<carcas><board><grass /><board /><player name="sam" /><carcas />
;'(start)
;<start />
;====================================================;
(define a0 '((initial "X")))
(define a1 '((random "random")))

(define als '((initial "X") (random "random")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))
;====================================================;
; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe

(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) '((initial "X")))
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) '((initial "X")))

(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

; AttrsOrXexpr -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))
;=366================================================;
; Xexpr.v2 -> Symbol
; retrieves the name of xe

(check-expect (xexpr-name e0) 'machine)
(check-expect (xexpr-name e1) 'machine)
(check-expect (xexpr-name e2) 'machine)
(check-expect (xexpr-name e3) 'machine)
(check-expect (xexpr-name e4) 'machine)

(define (xexpr-name xe) (first xe))
;=366================================================;
; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the list of Xexpr.v2 of xe

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))

(define (xexpr-content xe)
  (local ((define body (rest xe)))
    (cond
      [(empty? body) body]
      [else
       (if (not (list-of-attributes? (first body)))
           body
           (rest body))])))
;=369================================================;
; [List-of Attribute] Symbol -> [or String #false]
; If the attributes list associates the symbol with a
; string, the function retrieves this string
; otherwise it returns #false.

(check-expect (find-attr '() 'initial) #false)
(check-expect (find-attr a0 'initial) "X")
(check-expect (find-attr a0 'initialD) #false)
(check-expect (find-attr als 'random) "random")

(define (find-attr al sym)
  (local ((define attr (assq sym al)))
    (if (list? attr) (second attr) attr)))