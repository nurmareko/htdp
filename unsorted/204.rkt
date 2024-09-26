;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |204|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; LTracks is one of:
; – '()
; – (cons Track LTracks)

; List-of-LTracks is one of:
; - '()
; - (cons LTracks List-of-LTracks)

; A Track is a structure:
;   (make-track String String String N N Date N Date)

; A Date is a structure:
;   (make-date N N N N N N)

; List-of-Albums is one of:
; - empty
; - (list String List-of-Albums)

; Date
(define added
  (create-date 2019 3 1 11 19 59))
(define played
  (create-date 2022 8 23 4 8 00))

; Track
(define t1
  (create-track "Robinson"
                "Spitz" "Robinson"
                240000 1 added 6 played))
(define t2
  (create-track "Ore no Subete"
                "Spitz" "Robinson"
                240000 2 added 2 played))
(define t3
  (create-track "Tsugumi"
                "Spitz" "Tsugumi"
                240000 1 added 1 played))
(define t4
  (create-track "Hana No Shashin"
                "Spitz" "Tsugumi"
                180000 2 added 1 played))
(define t5
  (create-track "kiss"
                "Chara" "Kiss"
                300000 1 added 15 played))
(define t6
  (create-track "Tomorrow"
                "Chara" "Kiss"
                180000 2 added 4 played))
(define t7
  (create-track "Time After Time"
                "Chara" "Kiss"
                300000 3 added 12 played))
(define t8
  (create-track "Ya Ya (Ano Jidai wo Wasurenai"
                "Chara" "Kiss"
                240000 4 added 9 played))
(define t9
  (create-track "Kieru"
                "Chara" "Kiss"
                300000 5 added 4 played))

; LTracks
;(define ITUNES-LOCATION "iTunes Music Library.xml")
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))

(define ltrax
  (list t1 t2 t3 t4 t5 t6 t7 t8 t9))

(define robinson
  (list t1 t2))

(define tsugumi
  (list t3 t4))

(define kiss
  (list t5 t6 t7 t8 t9))

; LTracks -> List-of-LTracks
; produces a list of LTracks, one per album.
(define (select-albums list)
  (group (select-album-titles/unique list) list))

; List-of-Albums LTrack -> List-of-LTracks
; group tracks per album titles
(define (group albums list)
  (cond
    [(empty? albums) albums]
    [else (cons (select-album (first albums) list)
                (group (rest albums) list))]))

; LTracks -> List-of-Albums
; produces a list of unique album titles.
(define (select-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))

; String lTracks -> lTracks
; produce list of tracks that belong to the given
; album.
(define (select-album tittle list)
  (cond
    [(empty? list) list]
    [else
     (if (string=? tittle (track-album (first list)))
         (cons (first list)
               (select-album tittle (rest list)))
         (select-album tittle (rest list)))]))

; List-of-Albums -> List-of-Albums
; constructs one that contains every String from the
; given list exactly once.
(define (create-set los)
  [cond
    [(empty? los) los]
    [else (if (member? (first los) (rest los))
              (create-set (rest los))
              (cons (first los)
                    (create-set (rest los))))]])

; LTracks -> List-of-Albums
; produces the list of album titles.
(define (select-all-album-titles lt)
  (cond
    [(empty? lt) lt]
    [else
     (cons (track-album (first lt))
           (select-all-album-titles (rest lt)))]))

; tests
(check-expect (select-albums empty)
              empty)

(check-expect (select-albums ltrax)
              (list robinson tsugumi kiss))