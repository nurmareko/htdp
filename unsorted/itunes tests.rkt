;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |itunes tests|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; modify the following to use your chosen name
(define ITUNES-LOCATION "iTunes Music Library.xml")
 
; LTracks
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))

(define date-added
  (create-date 2002 3 1 11 19 59))

(define last-played
  (create-date 2022 8 23 4 8 00))

(define track
  (create-track "I Just Can't Breathe..."
                "the brilliant green"
                "Blackout"
                300000
                11
                date-added
                30
                last-played))
                
                
                