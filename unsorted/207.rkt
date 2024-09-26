;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |207|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; Association examples
(define name.
  (list "Name" "だからこそ (Dakarakoso)"))
(define artist.
  (list "Artist" "Izmi"))
(define album.
  (list "Album" "With You"))
(define time.
  (list "Total Time" 296426))
(define track#.
  (list "Track Number" 1))
(define added.
  (list "Date Added" (create-date 2018 5 31 18 24 29)))
(define play#.
  (list "Play Count" 8))
(define played.
  (list "Date Modified" (create-date 2018 5 31 18 24 31)))

; LAssoc examples
(define trax1
  (list
   (list "Track ID" 603)
   (list "Size" 10855722)
   (list "Total Time" 296426)
   (list "Disc Number" 1)
   (list "Disc Count" 1)
   (list "Track Number" 1)
   (list "Track Count" 9)
   (list "Year" 2012)
   (list "Date Modified" (create-date 2018 5 31 18 24 31))
   (list "Date Added" (create-date 2018 5 31 18 24 29))
   (list "Bit Rate" 256)
   (list "Sample Rate" 44100)
   (list "Play Count" 8)
   (list "Persistent ID" "D273867A03F032CC")
   (list "Track Type" "File")
   (list "File Folder Count" 4)
   (list "Library Folder Count" 1)
   (list "Name" "だからこそ (Dakarakoso)")
   (list "Artist" "Izmi")
   (list "Album" "With You")
   (list "Genre" "Pop")
   (list "Kind" "Purchased AAC audio file")
   (list "Location" "this is a psuedo location")))
  
(define trax2
  (list
   (list "Track ID" 605)
   (list "Size" 12992637)
   (list "Total Time" 376560)
   (list "Disc Number" 1)
   (list "Disc Count" 1)
   (list "Track Number" 6)
   (list "Track Count" 9)
   (list "Year" 2012)
   (list "Date Modified" (create-date 2018 5 31 18 24 32))
   (list "Date Added" (create-date 2018 5 31 18 24 30))
   (list "Bit Rate" 256)
   (list "Sample Rate" 44100)
   (list "Play Count" 8)
   (list "Persistent ID" "271189555E3C6454")
   (list "Track Type" "File")
   (list "File Folder Count" 4)
   (list "Library Folder Count" 1)
   (list "Name" "手 (Te)")
   (list "Artist" "Izmi")
   (list "Album" "With You")
   (list "Genre" "Pop")
   (list "Kind" "Purchased AAC audio file")
   (list "Location" "this is a psuedo location")))
  
(define trax3
  (list
   (list "Track ID" 1615)
   (list "Size" 11906636)
   (list "Total Time" 297404)
   (list "Disc Number" 1)
   (list "Track Number" 6)
   (list "Date Modified" (create-date 2018 5 31 18 28 26))
   (list "Date Added" (create-date 2018 5 31 18 28 26))
   (list "Bit Rate" 320)
   (list "Sample Rate" 44100)
   (list "Play Count" 2)
   (list "Persistent ID" "2DDF2CC8ECF32766")
   (list "Track Type" "File")
   (list "File Folder Count" 4)
   (list "Library Folder Count" 1)
   (list "Name" "はちみつ")
   (list "Artist" "Chara")
   (list "Album" "Secret Garden")
   (list "Kind" "MPEG audio file")
   (list "Location" "this is a psuedo location")))
  
(define trax4
 (list
  (list "Track ID" 1617)
  (list "Size" 8826279)
  (list "Total Time" 220395)
  (list "Disc Number" 1)
  (list "Track Number" 7)
  (list "Date Modified" (create-date 2018 5 31 18 28 26))
  (list "Date Added" (create-date 2018 5 31 18 28 26))
  (list "Bit Rate" 320)
  (list "Sample Rate" 44100)
  (list "Play Count" 3)
  (list "Persistent ID" "23EAA00C0D60B7EC")
  (list "Track Type" "File")
  (list "File Folder Count" 4)
  (list "Library Folder Count" 1)
  (list "Name" "恋は危険さ")
  (list "Artist" "Chara")
  (list "Album" "Secret Garden")
  (list "Kind" "MPEG audio file")
  (list "Location" "this is a psuedo location")))

;  LLists examples
(define ITUNES-LOCATION "iTunes Music Library.xml")
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))
(define trax-list
  (list trax1 trax2 trax3 trax4))

; LList -> Number
(define (total-time/list list)
  (cond
    [(empty? list) 0]
    [else
     (+ (second (assoc "Total Time" (first list)))
     (total-time/list (rest list)))]))

; tests
(check-expect (total-time/list empty)
              0)
(check-expect (total-time/list (list trax1))
              296426)
(check-expect (total-time/list trax-list)
              1190785)