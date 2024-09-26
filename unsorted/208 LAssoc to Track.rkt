;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |208 LAssoc to Track|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; track examples
(define track1
  (list (list "Name" "The Road With You")
        (list "Artist" "Izmi")
        (list "Album" "With You")
        (list "Total Time" 219773)
        (list "Track Number" 4)
        (list "Date Added" (create-date 2018 5 31 18 24 33))
        (list "Play Count" 8)
        (list "Play Date UTC" (create-date 2018 6 26 7 48 19))))
(define track2
  (list (list "Name" "The Road With You")
        (list "Artist" "Izmi")
        (list "Album" "With You")
        (list "Total Time" 219773)
        (list "Track Number" 4)
        (list "Date Added" (create-date 2018 5 31 18 24 33))
        (list "Play Count" 8)))


; LAssoc -> Any
; converts an LAssoc to a Track when possible.
(define (track-as-struct as)
  (if (and (list? (assoc "Name" as))
           (list? (assoc "Artist" as))
           (list? (assoc "Album" as))
           (list? (assoc "Total Time" as))
           (list? (assoc "Track Number" as))
           (list? (assoc "Date Added" as))
           (list? (assoc "Play Count" as))
           (list? (assoc "Play Date UTC" as)))
      (create-track (second (assoc "Name" as))
                    (second (assoc "Artist" as))
                    (second (assoc "Album" as))
                    (second (assoc "Total Time" as))
                    (second (assoc "Track Number" as))
                    (second (assoc "Date Added" as))
                    (second (assoc "Play Count" as))
                    (second (assoc "Play Date UTC" as)))
      #false))
           
; tests
(check-expect (track-as-struct empty)
              #false)
  (check-expect (track-as-struct track2)
              #false)
(check-expect (track-as-struct track1)
              (create-track "The Road With You"
                            "Izmi"
                            "With You"
                            219773
                            4
                            (create-date 2018 5 31 18 24 33)
                            8
                            (create-date 2018 6 26 7 48 19)))