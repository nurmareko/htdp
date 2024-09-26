;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |377|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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
(define i1 '(li (word ((text "I just came")))))
(define i2 '(li (word ((text "to say")))))
(define i3 '(li (word ((text "hello")))))

(define bye '(li (word ((text "bye")))))

(define e1 `(ul ,i1))
(define e2 `(ul ,i1 ,i2))
(define e3 `(ul ,i1 ,i2 ,i3))

;; XEnum.v2 -> XEnum.v2
;; replaces all occurences of "hello" in xe with "bye"
(check-expect (replace-hello e1) e1)
(check-expect (replace-hello e2) e2)
(check-expect (replace-hello e3) `(ul ,i1 ,i2 ,bye))
(check-expect (replace-hello (list
                              'ul
                              (list 'li (list 'word (list (list 'text "I just came"))))
                              (list 'li (list 'ul
                                              (list 'li (list 'word (list (list 'text "to say"))))
                                              (list 'li (list 'word (list (list 'text "hello"))))
                                              (list 'li (list 'word (list (list 'text "hello"))))))))
              (list
               'ul
               (list 'li (list 'word (list (list 'text "I just came"))))
               (list 'li (list 'ul
                               (list 'li (list 'word (list (list 'text "to say"))))
                               (list 'li (list 'word (list (list 'text "bye"))))
                               (list 'li (list 'word (list (list 'text "bye"))))))))

(define (replace-hello xe)
  (cons (xexpr-name xe) (for-content (xexpr-content xe))))

; [List-of Xitem.v2] -> [List-of Xitem.v2]
(define (for-content lxi)
  (cond
    [(empty? lxi) lxi]
    [else
     (cons (for-xitem (first lxi))
           (for-content (rest lxi)))]))

; XItem.v2 -> XItem.v2
(define (for-xitem xi)
  (cond
    [(word? (second xi)) (cons 'li (cons (for-word (second xi)) '()))]
    [else (cons 'li (cons (replace-hello (second xi)) '()))]))

; XWord.v2 -> XWord.v2
(define (for-word xw)
  (list 'word (list (list 'text (if (equal? "hello" (word-text xw)) "bye" (word-text xw))))))
;====================================================;
; Xexpr.v2 -> Symbol
; retrieves the name of xe
(define (xexpr-name xe) (first xe))
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