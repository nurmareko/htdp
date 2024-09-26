;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |202|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; An LTracks is one of:
; – '()
; – (cons Track LTracks)

; A Track is a structure:
;   (make-track String String String N N Date N Date)

; A Date is a structure:
;   (make-date N N N N N N)

; List-of-Strings is:
; - empty
; - (cons String List-of-Strings)
 
; Date
(define date-added
  (create-date 2002 3 1 11 19 59))
(define last-played
  (create-date 2022 8 23 4 8 00))

; Track
(define trax-1
  (create-track "I Just Can't Breathe..."
                "the brilliant green" "Blackout"
                300000 11 date-added 32 last-played))
(define trax-2
  (create-track "Robinson"
                "Spitz" "Hachimitsu"
                240000 8 date-added 17 last-played))

; LTracks
(define ITUNES-LOCATION "iTunes Music Library.xml")
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))
(define ltrax
  (list trax-1 trax-2))

; String lTracks -> lTracks
; produce list of tracks that belong to the given
; album.
(define (select-album tittle list)
  (cond
    [(empty? list) list]
    [else (if (string=? tittle (track-album (first list)))
              (cons (first list) (select-album tittle (rest list)))
              (select-album tittle (rest list)))]))
  
; tests
(check-expect (select-album "Hachimitsu" empty)
              empty)
(check-expect (select-album "Hachimitsu" ltrax)
              (list trax-2))
(check-expect (select-album "Hachimitsu" (list trax-2 trax-2 trax-1))
              (list trax-2 trax-2))
(check-expect (select-album "Hachimitsu" (list trax-1 trax-2 trax-2))
              (list trax-2 trax-2))
