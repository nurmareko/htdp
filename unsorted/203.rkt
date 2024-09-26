;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |203|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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
(define future-date
  (create-date 2022 9 23 4 8 00))
(define past-date
  (create-date 2022 3 3 4 8 00))

; Track
(define trax-1
  (create-track "I Just Can't Breathe..."
                "the brilliant green" "Blackout"
                300000 11 date-added 32 last-played))
(define trax-2
  (create-track "Robinson"
                "Spitz" "Hachimitsu"
                240000 8 date-added 17 last-played))
(define trax-3
  (create-track "Time Machine"
                "Chara" "Junior Sweet"
                360000 5 date-added 11 past-date))
(define trax-4
  (create-track "Milk"
                "Chara" "Junior Sweet"
                360000 1 date-added 7 future-date))

; LTracks
(define ITUNES-LOCATION "iTunes Music Library.xml")
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))
(define ltrax
  (list trax-1 trax-2))
(define chara
  (list trax-3 trax-4))

; String Date LTrack -> LTrack
; produce list of tracks that belong to the given
; album and have been played after the given date.
(define (select-album-date title date list)
  (played-after date (select-album title list)))

; String lTracks -> lTracks
; produce list of tracks that belong to the given
; album.
(define (select-album tittle list)
  (cond
    [(empty? list) list]
    [else (if (string=? tittle (track-album (first list)))
              (cons (first list) (select-album tittle (rest list)))
              (select-album tittle (rest list)))]))

; Date LTrack -> LTrack
; produce list of tracks that have been played after
; the given date.
(define (played-after date list)
  (cond
    [(empty? list) list]
    [else (if (after-date?  date (track-played (first list)))
              (cons (first list) (played-after date (rest list)))
              (played-after date (rest list)))]))

; Date Date -> Boolean
; determines whether the second date is after the first date
(define (after-date? a b)
  (cond
    [(> (date-year b) (date-year a)) #true]
    [(> (date-month b) (date-month a)) #true]
    [(> (date-day b) (date-day a)) #true]
    [(> (date-hour b) (date-hour a)) #true]
    [(> (date-minute b) (date-minute a)) #true]
    [(> (date-second b) (date-second a)) #true]
    [else #false]))

; tests
(check-expect
 (select-album-date "Blackout" past-date ltrax)
 (list trax-1))
(check-expect
 (select-album-date "Blackout" future-date ltrax)
 empty)
(check-expect
 (select-album-date "Blackout" past-date ltrax)
 (list trax-1))
(check-expect
 (select-album-date "Junior Sweet" last-played chara)
 (list trax-4))
(check-expect
 (select-album-date "Junior Sweet" past-date chara)
 (list trax-4))