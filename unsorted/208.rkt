;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |208|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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
  (list "Track ID" 444)
  (list "Name" "Only Time")
  (list "Artist" "Enya")
  (list "Album" "A Day Without Rain")
  (list "Genre" "New Age")
  (list "Kind" "MPEG audio file")
  (list "Size" 4364035)
  (list "Total Time" 218096)
  (list "Track Number" 3)
  (list "Track Count" 11)
  (list "Year" 2000)
  (list "Date Modified" (create-date 2002 7 17 0 0 21))
  (list "Date Added" (create-date 2002 7 17 3 55 42))
  (list "Bit Rate" 160)
  (list "Sample Rate" 44100)
  (list "Play Count" 18)
  (list "Play Date" 3388484327)
  (list "Play Date UTC" (create-date 2011 5 17 17 38 47))
  (list "Sort Album" "Day Without Rain")
  (list "Persistent ID" "EBBE9171392FA34A")
  (list "Track Type" "File")))
  
(define trax2
 (list
  (list "Track ID" 442)
  (list "Name" "Wild Child")
  (list "Artist" "Enya")
  (list "Album" "A Day Without Rain")
  (list "Genre" "New Age")
  (list "Kind" "MPEG audio file")
  (list "Size" 4562044)
  (list "Total Time" 227996)
  (list "Track Number" 2)
  (list "Track Count" 11)
  (list "Year" 2000)
  (list "Date Modified" (create-date 2002 7 17 0 0 11))
  (list "Date Added" (create-date 2002 7 17 3 55 14))
  (list "Bit Rate" 160)
  (list "Sample Rate" 44100)
  (list "Play Count" 20)
  (list "Play Date" 3388484113)
  (list "Play Date UTC" (create-date 2011 5 17 17 35 13))
  (list "Sort Album" "Day Without Rain")
  (list "Persistent ID" "EBBE9171392FA348")
  (list "Track Type" "File")))
  
(define trax3
 (list
  (list "Track ID" 3990)
  (list "Name" "He Can Only Hold Her")
  (list "Artist" "Amy Winehouse")
  (list "Album Artist" "Amy Winehouse")
  (list
   "Composer"
   "Amy Winehouse, Richard Poindexter, Robert Poindexter 38 John Harrison")
  (list "Album" "iTunes Festival: London 2007")
  (list "Genre" "Pop")
  (list "Kind" "Purchased AAC audio file")
  (list "Size" 6856755)
  (list "Total Time" 191866)
  (list "Disc Number" 1)
  (list "Disc Count" 1)
  (list "Track Number" 7)
  (list "Track Count" 8)
  (list "Year" 2007)
  (list "Date Modified" (create-date 2014 10 11 23 43 14))
  (list "Date Added" (create-date 2014 10 20 14 31 25))
  (list "Bit Rate" 256)
  (list "Sample Rate" 44100)
  (list "Play Count" 6)
  (list "Play Date" 3498740411)
  (list "Play Date UTC" (create-date 2014 11 13 21 20 11))
  (list "Release Date" (create-date 2007 8 13 7 0 0))
  (list "Normalization" 5811)
  (list "Artwork Count" 1)
  (list "Persistent ID" "909150FDAC57DBBF")
  (list "Track Type" "File")
  (list "Purchased" #true)))
  
(define trax4
 (list
  (list "Track ID" 3992)
  (list "Name" "Monkey Man")
  (list "Artist" "Amy Winehouse")
  (list "Album Artist" "Amy Winehouse")
  (list "Composer" "Frederick Hibbert")
  (list "Album" "iTunes Festival: London 2007")
  (list "Genre" "Pop")
  (list "Kind" "Purchased AAC audio file")
  (list "Size" 6769836)
  (list "Total Time" 188813)
  (list "Disc Number" 1)
  (list "Disc Count" 1)
  (list "Track Number" 8)
  (list "Track Count" 8)
  (list "Year" 2007)
  (list "Date Modified" (create-date 2014 10 11 23 43 10))
  (list "Date Added" (create-date 2014 10 20 14 31 25))
  (list "Bit Rate" 256)
  (list "Sample Rate" 44100)
  (list "Play Count" 6)
  (list "Play Date" 3498740599)
  (list "Play Date UTC" (create-date 2014 11 13 21 23 19))
  (list "Release Date" (create-date 2007 8 13 7 0 0))
  (list "Normalization" 4904)
  (list "Artwork Count" 1)
  (list "Persistent ID" "39C9BD4120CCF2C2")
  (list "Track Type" "File")
  (list "Purchased" #true)))

;  LLists examples
(define ITUNES-LOCATION "iTunes Music Library.xml")
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))
(define trax-list
  (list trax1 trax2 trax3 trax4))

; LLists -> List-of-String
; produces the Strings that are associated with a
; Boolean attribute.
(define (boolean-attributes li)
  (create-set
   (remove-all empty (boolean-lassoc li))))

; LLists -> List-of-Strings
; create list of string from LAssoc that contain boolean
(define (boolean-lassoc li)
  (cond
    [(empty? li) li]
    [else (cons (any-boolean? (first li))
                (boolean-lassoc (rest li)))]))

; LAssoc -> String
; create string from assoc that contain boolean
(define (any-boolean? li)
  (cond
    [(empty? li) li]
    [else (if (boolean? (second (first li)))
              (first (first li))
              (any-boolean? (rest li)))]))
    
; List-of-Strings -> List-of-Strings
; constructs one that contains every String from the
; given list exactly once.
(define (create-set los)
  [cond
    [(empty? los) los]
    [else (if (member? (first los) (rest los))
              (create-set (rest los))
              (cons (first los) (create-set (rest los))))]])

; tests
(check-expect (boolean-attributes trax-list)
              (list "Purchased"))
(check-expect (any-boolean? trax1)
              empty)
(check-expect (any-boolean? trax2)
              empty)
(check-expect (any-boolean? trax3)
              "Purchased")
(check-expect (any-boolean? trax4)
              "Purchased")
(check-expect (boolean-lassoc trax-list)
              (list empty empty "Purchased" "Purchased"))
(check-expect (boolean-lassoc empty)
              empty)
              