;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |5|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

(define SIZE 30)
(define BODY (rectangle (* SIZE 2) SIZE "solid" "blue"))
(define SAIL (triangle (* SIZE 2) "solid" "red"))
(define POLE (rectangle (/ SIZE 2) (/ SIZE 2) "solid" "black"))
(define BOAT (above SAIL POLE BODY))
(define SCENE (empty-scene (* SIZE 5) (* SIZE 5)))

(overlay/align "middle" "middle"
               BOAT
               SCENE)
