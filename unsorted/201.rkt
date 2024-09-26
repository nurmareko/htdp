;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |201|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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
;(define ITUNES-LOCATION "iTunes Music Library.xml")
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))
(define ltrax
  (list trax-1 trax-2))

; Ltrack -> List-of-Strings
; produces the list of album titles.
(define (select-all-album-titles lt)
  (cond
    [(empty? lt) lt]
    [else (cons (track-album (first lt))
                (select-all-album-titles (rest lt)))]))

; List-of-Strings -> List-of-Strings
; constructs one that contains every String from the
; given list exactly once.
(define (create-set los)
  [cond
    [(empty? los) los]
    [else (if (member? (first los) (rest los))
              (create-set (rest los))
              (cons (first los) (create-set (rest los))))]])

; LTracks -> List-of-Strings
; produces a list of unique album titles.
(define (select-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))

; tests
(check-expect
 (select-album-titles/unique empty)
 empty)
(check-expect
 (select-album-titles/unique (list trax-1 trax-1 trax-2))
 (list "Blackout" "Hachimitsu"))
(check-expect
 (select-album-titles/unique (list trax-1 trax-2 trax-2))
 (list "Blackout" "Hachimitsu"))
(check-expect
 (select-album-titles/unique (list trax-1 trax-1 trax-2 trax-2))
 (list "Blackout" "Hachimitsu"))
(check-expect
 (create-set (list "Blackout"))
 (list "Blackout"))
(check-expect
 (create-set (list "Blackout" "Blackout"))
 (list "Blackout"))
(check-expect
 (create-set (list "Hachimitsu" "Blackout" "Blackout"))
 (list "Hachimitsu" "Blackout"))
(check-expect
 (create-set (list "Hachimitsu" "Hachimitsu" "Blackout"))
 (list "Hachimitsu" "Blackout"))
(check-expect
 (create-set (list "Hachimitsu" "Hachimitsu" "Blackout" "Blackout"))
 (list "Hachimitsu" "Blackout"))
 (check-expect
 (select-all-album-titles empty)
 empty)
(check-expect
 (select-all-album-titles ltrax)
 (list "Blackout" "Hachimitsu"))