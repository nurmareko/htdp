;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 76|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
; A Movie is a structure:
;     (make-movie String String String)
; interpretation a movie's description title, producer, and published year

(define-struct person [name hair eyes phone])
; A Person is a structure:
;     (make-person String String String Number)
; interpretation a person's descriptin name, hair color, eyes color, and phone number

(define-struct pet [name number])
; A Pet is a structure:
;     (make-pet String Number)
; interpretation a pet's name, and ID number

(define-struct CD [artist title price])
; A CD is a structure:
;     (make-CD String String Number)
; interpretation a CD's description artist name, album title, and price

(define-struct sweater [material size producer])
; A Sweater is a structure:
;     (make-sweater String String String)
; interpretation a sweater's material type, fit size, and producer/company name

(define-struct TS-midnight [hour minute second])
; A TS-midnight is a structure:
;     (TS-midnight Number Number Number)
; interpretion points in time since midnight hour, minute, and second