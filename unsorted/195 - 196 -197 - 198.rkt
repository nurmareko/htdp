;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |195 - 196 -197 - 198|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; On OS X: 
(define LOCATION "words.txt")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))
(define-struct LC [letter count])
; Letter-Counts is (make-LC Letter Number)
; a piece of data that combines letters and counts.

; LoLC (List-of-Letter-Counts) is:
; - empty
; - (list Letter-Counts LoLC)

; Lo1s (List-of-1String) is:
; - empty
; - (list 1string Lo1s)

; List-of-Dictionary is:
; - (list Dictionary)
; - (list Dictionary List-of-Dictionary)

;----------------------- 195 -----------------------;
; Letter Dictionary -> Number
; counts how many words in the given Dictionary li
; start with the given Letter s.
(define (starts-with# s li)
  (cond
    [(empty? li) 0]
    [else (if (string=? s (first-str (first li)))
              (+ 1 (starts-with# s (rest li)))
              (starts-with# s (rest li)))]))           

; String -> 1String
; extract the first 1String from str
(define (first-str str)
  (substring str 0 1))
;---------------------------------------------------;

;----------------------- 196 -----------------------;
; Dictionary -> LoLC
; counts how often each Letter is used as the first
; one of a word in the given dictionary.
(define (count-by-letter dict)
  (line-by-lo1s dict LETTERS))

; Los Lo1s -> LoLC
; counts how often each 1string in Lo1c is use as the
; start of line in Los
(define (line-by-lo1s los lo1s)
  (cond
    [(empty? lo1s) lo1s]
    [else (cons (make-LC
                 (first lo1s)
                 (starts-with# (first lo1s) los))
                (line-by-lo1s los (rest lo1s)))]))
;---------------------------------------------------;

;----------------------- 197 -----------------------;
; Dictionary -> Letter-Counts
; produces the Letter-Count for the letter that
; occurs most often as the first one in the given
; Dictionary.
(define (most-frequent dict)
  (first (short-count> (line-by-lo1s dict LETTERS))))

; LoLC -> LoLC
; short list of letter counts base on its count in
; descending order.
(define (short-count> lolc)
  (cond
    [(empty? lolc) '()]
    [else
     (insert (first lolc)
             (short-count> (rest lolc)))]))

; Letter-Counts LoLC -> LoLC
; inserts n into the sorted list of numbers alon
(define (insert lc lolc)
  (cond
    [(empty? lolc) (list lc)]
    [else (if (count>= lc (first lolc))
              (cons lc lolc)
              (cons (first lolc)
                    (insert lc (rest lolc))))]))

; LC LC -> LoLC
; is a larger than b?
(define (count>= a b)
  (if (>= (LC-count a) (LC-count b))
      #t #f))
;---------------------------------------------------;

;----------------------- 198 -----------------------;
; Dictionary -> List-of-Dictionary
; produces a list of Dictionarys, one per Letter.
(define (words-by-first-letter dict)
  (remove-all empty (group-los dict LETTERS)))

; Dictionary Letter -> List-of-Dictionary
; group list of string by its first letter
; base on 1String on list of 1String.
(define (group-los los lo1s)
  (cond
    [(empty? lo1s) lo1s]
    [else (cons (group-by-1s los (first lo1s))
                (group-los los (rest lo1s)))]))

; Dictionary Letter -> List-of-Dictionary
; filter a list of string if its first letter is not
; 1s
(define (group-by-1s los 1s)
  (cond
    [(empty? los) los]
    [else (if (string=? (first-str (first los)) 1s)
              (cons (first los)
                    (group-by-1s (rest los) 1s))
              (group-by-1s (rest los) 1s))]))

; Dictionary -> Letter-Counts
; produces the Letter-Count for the letter that
; occurs most often as the first one in the given
; Dictionary.
(define (most-frequent.v2 dict)
  (los->LC
   (first
    (lod-count>
     (words-by-first-letter dict)))))

; Los -> Letter-Counts
; create Letter-Counts base on los
(define (los->LC los)
  (make-LC (first-str (first los))
           (length los)))

; Lod -> Lod
; short Lod by most content
(define (lod-count> lod)
  (cond
    [(empty? lod) '()]
    [else
     (insert.v2 (first lod)
             (lod-count> (rest lod)))]))

; Dictionary Lod -> Lod
; short list of dictionary base on its length in
; descending order.
(define (insert.v2 dict lod)
  (cond
    [(empty? lod) (list dict)]
    [else (if (>= (length dict) (length (first lod)))
              (cons dict lod)
              (cons (first lod)
                    (insert.v2 dict (rest lod))))]))
      
;---------------------------------------------------;

; tests
(define 3balls
  (list "balls" "balls" "balls"))
(define ac-dict
  (list "ass" "ama" "abba" "cool" "comas"))
(define cd-dict
  (list "car" "dog" "dick"))
(define abc
  (list "a" "b" "c"))

(check-expect (starts-with# "a" empty)
              0)
(check-expect (starts-with# "a" (list "be" "ce"))
              0)
(check-expect (starts-with# "a" (list "a" "be" "ce"))
              1)
(check-expect (starts-with# "a" (list "be" "ce" "aa" "aa"))
              2)
(check-expect (first-str "apple")
              "a")
(check-expect (first-str "balls")
              "b")
(check-expect (first-str "a")
              "a")
(check-expect
 (count-by-letter (list "a" "aAd" "b" "ab" "c"))
 (list (make-LC "a" 3) (make-LC "b" 1) (make-LC "c" 1)
       (make-LC "d" 0) (make-LC "e" 0) (make-LC "f" 0)
       (make-LC "g" 0) (make-LC "h" 0) (make-LC "i" 0)
       (make-LC "j" 0) (make-LC "k" 0) (make-LC "l" 0)
       (make-LC "m" 0) (make-LC "n" 0) (make-LC "o" 0)
       (make-LC "p" 0) (make-LC "q" 0) (make-LC "r" 0)
       (make-LC "s" 0) (make-LC "t" 0) (make-LC "u" 0)
       (make-LC "v" 0) (make-LC "w" 0) (make-LC "x" 0)
       (make-LC "y" 0) (make-LC "z" 0)))
(check-expect (most-frequent 3balls)
              (make-LC "b" 3))
(check-expect (group-los ac-dict abc)
              (list (list "ass" "ama" "abba")
                    empty
                    (list "cool" "comas")))
(check-expect (group-by-1s ac-dict "a")
              (list "ass" "ama" "abba"))
(check-expect (group-by-1s ac-dict "b")
              empty)
(check-expect (group-by-1s ac-dict "c")
              (list "cool" "comas"))
(check-expect (words-by-first-letter ac-dict)
              (list (list "ass" "ama" "abba")
                    (list "cool" "comas")))
(check-expect (most-frequent 3balls)
              (make-LC "b" 3))
(check-expect (lod-count> (words-by-first-letter ac-dict))
              (words-by-first-letter ac-dict))
(check-expect (lod-count> (words-by-first-letter cd-dict))
              (list (list "dog" "dick")
                    (list "car")))
(check-expect (most-frequent.v2 AS-LIST)
              (most-frequent AS-LIST))