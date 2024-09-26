;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |510|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; N String String -> String
; arrange words in f-in into lines  of maximal width w,
; and to write these lines to out-f.
; assume the content of f-in doesn't contain any "\n"

; [List-of Line] -> Boolean
(define (line-under-40? ln)
  (andmap (lambda (line) (<= (string-length line) 40)) ln))

(check-satisfied (read-lines (fmt 40 "510-in.txt" "510-out.txt")) line-under-40?)

(define (fmt w f-in f-out)
  (local ((define content (read-1strings f-in))
          ; [List-of 1String] String String -> String
          ; create a string from alo1s with "\n" placed for every 'w' items
          ; acccumulator 'line' is to be the line with maximal width w.
          ; accumulator 'text-fmtd' is to be the result of the words in f-in formatted.
          (define (fmt/a alo1s line text-fmtd)
            (cond
              [(empty? alo1s) (string-append text-fmtd line)]
              [else
               (fmt/a (rest alo1s)
                      (if (= (string-length line) w)
                          (first alo1s)
                          (string-append line (first alo1s)))
                      (if (= (string-length line) w)
                          (string-append text-fmtd line "\n")
                          text-fmtd))])))
     (write-file f-out (fmt/a content "" ""))))