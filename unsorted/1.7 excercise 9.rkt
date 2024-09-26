;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |1.7 excercise 9|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/image)

(define in #false)

(cond [(number? in) (abs in)]
      [(string? in) (string-length in)]
      [(image? in) (* (image-width in) (image-height in))]
      [(boolean? in) (if (not in) 20 10) ]
      )