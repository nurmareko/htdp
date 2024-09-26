;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |371|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; An Xexpr.v2 is:
;  (cons Symbol Body)


; A Body is one of:
; - empty
; - [List-of Xexpr.v2]
; - (cons [List-of Attribute] [List-of Xexpr.v2])
; - XWord

; An Attribute is:
;  (list Symbol String)

; An [Or X Y] is one of:
; - X
; - Y

; An AttrsOrXexpr is
;  [Or [List-of Attribute] Xexpr.v2]

; An XWord is an Xexpr.v2:
;  '(word ((text String)))

; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons Attributes [List-of XItem.v1]))

; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons Attributes (cons XWord '())))
;===================================================;
; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attr xe)
  (local ((define body (rest xe)))
    (cond
      [(empty? body) '()]
      [else
       (local ((define loa-or-x (first body)))
         (if (attributes? loa-or-x)
             loa-or-x '()))])))
; AttrsOrXexpr -> Boolean
; is x a list of attributes
(define (attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))
; Xexpr.v2 -> Symbol
; retrieves the name of xe
(define (xexpr-name xe) (first xe))
; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the list of Xexpr.v2 of xe
(define (xexpr-content xe)
  (local ((define body (rest xe)))
    (cond
      [(empty? body) body]
      [else
       (if (not (attributes? (first body)))
           body (rest body))])))
; [List-of Attribute] Symbol -> [or String #false]
; find attribute with symbol, sym, in al
(define (find-attr al sym)
  (local ((define attr (assq sym al)))
    (if (list? attr) (second attr) attr)))
;=370===============================================;
(define w0 '(word ((text "hello"))))
(define w1 '(word ((text "world"))))
(define w2 '(word ((text "goodbye"))))

(check-expect (word? w0) #true)
(check-expect (word? w1) #true)
(check-expect (word? w2) #true)

(check-expect (word? '("word" ((text "goodbye")))) #false)
(check-expect (word? '(word (("text" "goodbye")))) #false)
(check-expect (word? '(word ((text goodbye)))) #false)
(check-expect (word? '(word word ((text "goodbye")))) #false)
(check-expect (word? '(word ((text "goodbye" "goodbye")))) #false)
(check-expect (word? '(word ((text "hello") (text "hello")))) #false)
(check-expect (word? "hello") #false)
(check-expect (word? 10) #false)

(define (word? v)
  (and
   (and (list? v) (= 2 (length v)))
   (local ((define x (first v)))
     (and (symbol? x) (symbol=? 'word x)))
   (local ((define x (second v)))
     (and (list? x) (= 1 (length x))))
   (local ((define x (first (second v))))
     (and (list? x) (= 2 (length x))))
   (local ((define x (first (first (second v)))))
     (and (symbol? x) (symbol=? 'text x)))
   (string? (second (first (second v))))))
;===================================================;
; XWord -> String
; retrieves the value of xword

(check-expect (word-text w0) "hello")
(check-expect (word-text w1) "world")
(check-expect (word-text w2) "goodbye")

(define (word-text xw) (second (first (second xw))))