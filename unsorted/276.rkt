;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |276|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

; String Date [List-of Track] -> [List-of Track]
; extracts list of tracks from the given album name nm that have
; been played after the date dt.
(define (select-album-date nm dt l-t)
  (select-after-date dt (select-album nm l-t)))

; [List-of Track] -> [List-of [List-of Track]]
; produces a list of LTracks, one per album.
(define (select-albums l-t)
  (local [; String -> [List-of Track]
          (define (select s)
            (select-album s l-t))

          (define list-album
            (create-list-of-albums l-t))]
         ; - IN -
         (map select list-album)))
;==================================================================;
; String [List-of Track] -> [List-of Track]
; extracts list of tracks from the given album name nm
(define (select-album nm l-t)
  (local [; Track -> Boolean
          (define (album? t)
            (equal? (track-album t) nm))]
    ; - IN -
    (filter album? l-t)))

; Date [List-of Track] -> [List-of Track]
; extracts list of tracks that played on and after date dt
(define (select-after-date dt l-t)
  (local [; Track -> Boolean
          (define (date>= t)
            (>= (date->seconds (track-played t))
                (date->seconds dt)))]
    ; - IN -
    (filter date>= l-t)))

; [List-of Track] -> [List-of String]
; create list of unique album name
(define (create-list-of-albums l-t)
  (create-set (map track-album l-t)))

; [X] [List-of X] -> [List-of X]
; creates a copy of the list without repetitions
(define (create-set l)
  (cond
    [(empty? l) '()]
    [(cons? l)
     (if (member? (first l) (rest l))
         (create-set (rest l))
         (cons (first l) (create-set (rest l))))]))

; Date -> Number
; convert date to seconds
(define (date->seconds d)
  (+ (* (date-year   d) 31557600)
     (* (date-month  d) 2629800)
     (* (date-day    d) 86400)
     (* (date-hour   d) 3600)
     (* (date-minute d) 60)
     (date-second d)))
