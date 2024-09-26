;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |376|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (cons XEnum.v2 '())))
; 
; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem]

; An XWord is
;  '(word ((text String)))
;====================================================;
; XEnum.v2 -> Number
; count how many times "hello" is in XEnum, xe

(check-expect (count-hello '(ul)) 0)
(check-expect (count-hello '(ul (word ((text "hello"))))) 1)
(check-expect (count-hello '(ul (word ((text "hello"))) (word ((text "hello"))))) 2)
(check-expect (count-hello '(ul (word ((text "not"))) (word ((text "hello"))))) 1)
(check-expect (count-hello '(ul (li (ul)))) 0)
(check-expect (count-hello '(ul (li (word ((text "hello")))) (li (ul (li (word ((text "not")))) (li (word ((text "hello")))))))) 2)

(define (count-hello xe)
  (local (; [List-of XItem.v2] -> Number
          (define (for-lxi lxi)
            (cond
              [(empty? lxi) 0]
              [else
               (local ((define content (first lxi)))
                 (+ (if (word? content)
                        (if (equal? "hello" (word-text content)) 1 0)
                        (count-hello content))
                    (for-lxi (rest lxi))))])))
    (for-lxi (xexpr-content xe))))
;====================================================;
; Xexpr.v2 -> [List-of Xexpr.v2]
(define (xexpr-content v)
  (local ((define body (rest v))
          ; AttrsOrXexpr -> Boolean
          (define (attributes? x)
            (if (empty? x) #true (cons? (first x)))))
    (cond
      [(empty? body) body]
      [else
       (if (not (attributes? (first body)))
           body (rest body))])))
;====================================================;
; Any -> Boolean
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
;====================================================;
; XWord -> String
; retrieves the value of xword
(define (word-text xw) (second (first (second xw))))